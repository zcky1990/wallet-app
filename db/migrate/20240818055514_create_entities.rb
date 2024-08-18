class CreateEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :entities do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :email # For Users
      t.string :password_digest # For Users
      t.string :token
      t.datetime :token_expires_at
      t.string :symbol # For Stocks

      t.timestamps
    end

    add_index :entities, :email, unique: true # Ensure email uniqueness for Users
    add_index :entities, :type
  end
end
