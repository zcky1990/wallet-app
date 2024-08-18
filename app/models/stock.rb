class Stock < Entity
    has_one :wallet, as: :walletable
    has_many :transactions, as: :wallet
end
