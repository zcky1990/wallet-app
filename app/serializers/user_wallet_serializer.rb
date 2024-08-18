class UserWalletSerializer < ActiveModel::Serializer
  attributes :wallet_id, :balance_ammount

  def wallet_id
    object.id
  end

  def balance_ammount
    object.balance
  end
end
  