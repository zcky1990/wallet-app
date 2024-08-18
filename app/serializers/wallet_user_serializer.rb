class WalletUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  # Rename the `id` attribute to `wallet_id`
  def user_id
    object.id
  end
  
end
