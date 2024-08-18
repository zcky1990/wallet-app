class WalletSerializer < ActiveModel::Serializer
  attributes :wallet_id, :balance_ammount, :user

  def wallet_id
    object.id
  end

  def balance_ammount
    object.balance
  end

  def user
    WalletUserSerializer.new(object.walletable).as_json
  end
end
