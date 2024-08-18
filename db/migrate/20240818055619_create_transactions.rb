class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :target_wallet, foreign_key: { to_table: :wallets }
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :transaction_type, null: false

      t.timestamps
    end
  end
end
