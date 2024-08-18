class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :wallet

  # Rename the `id` attribute to `wallet_id`
  def user_id
    object.id
  end

  def wallet
    UserWalletSerializer.new(object.wallet).as_json
  end
end
