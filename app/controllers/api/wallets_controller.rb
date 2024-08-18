class Api::WalletsController < ApplicationController
    before_action :authenticate_request

    def transfer
        source_wallet = get_source_wallet
        target_wallet = find_wallet(params[:target_wallet_id])

        if source_wallet.nil? || target_wallet.nil?
            render json: { error: "Invalid wallet IDs provided." }, status: :unprocessable_entity
            return
        end

        amount = params[:amount].to_f
        transaction_type = params[:transaction_type]

        ActiveRecord::Base.transaction do
            case transaction_type
            when Transaction::CREDIT
                source_wallet.update!(balance: source_wallet.balance + amount)

                Transaction.create!(
                    wallet_id: source_wallet.id,
                    amount: amount,
                    transaction_type: Transaction::CREDIT
                )

            when Transaction::DEBIT
                if source_wallet.balance < amount
                    render json: { error: "Insufficient funds in source wallet." }, status: :unprocessable_entity
                    return
                end

                source_wallet.update!(balance: source_wallet.balance - amount)
                target_wallet.update!(balance: target_wallet.balance + amount)

                Transaction.create!(
                    wallet_id: source_wallet.id,
                    amount: amount,
                    transaction_type: Transaction::DEBIT,
                    target_wallet_id: target_wallet.id
                )
                
                Transaction.create!(
                    wallet_id: target_wallet.id,
                    amount: amount,
                    transaction_type: Transaction::CREDIT
                )

            else
                render json: { error: "Invalid transaction type." }, status: :unprocessable_entity
                return
            end
            render json: { message: "Transaction successful.", data: WalletSerializer.new(source_wallet).as_json }, status: :ok
        end
    rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
    end

    private
    
    def find_wallet(wallet_id)
        wallet = Wallet.find_by(id: wallet_id)
        return wallet if wallet.present?
        
        nil
    end

    def get_source_wallet
        @current_user.wallet if @current_user
    end
end
