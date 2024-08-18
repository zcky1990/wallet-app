class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true, null: false
      t.decimal :balance, default: 0.0, precision: 10, scale: 2

      t.timestamps
    end

    add_index :wallets, [:walletable_type, :walletable_id]
  end
end
