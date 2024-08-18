require 'bcrypt'

class User < Entity
  include BCrypt

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  has_one :wallet, as: :walletable
  has_many :transactions, as: :wallet

  def password
    @password ||= Password.new(password_digest) if password_digest.present?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def authenticate(password)
    stored_password = BCrypt::Password.new(password_digest)
    stored_password == password
  end

  private

  def password_required?
    password_digest.blank? || @password.present?
  end
end
    