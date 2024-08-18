class Transaction < ApplicationRecord
    belongs_to :wallet
    belongs_to :target_wallet, class_name: 'Wallet', optional: true

    validates :amount, presence: true, numericality: { greater_than: 0 }
    validate :validate_transaction

    DEBIT = 'debit'.freeze
    CREDIT = 'credit'.freeze

    def validate_transaction
        if credit? && wallet_id.nil?
            errors.add(:wallet_id, "must be present for credits")
        elsif debit?
            if wallet_id.nil?
                errors.add(:wallet_id, "must be present for debits")
            end
            if target_wallet_id.nil?
                errors.add(:target_wallet_id, "must be present for debits")
            end
        end
    end

    def credit?
        transaction_type == CREDIT
    end

    def debit?
        transaction_type == DEBIT
    end
end
