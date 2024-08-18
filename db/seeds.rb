# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data

Transaction.destroy_all
Wallet.destroy_all
Entity.destroy_all

# Create Users with BCrypt password digest
user1 = Entity.create!(type: 'User', name: 'admin', email: 'admin@example.com', password_digest: BCrypt::Password.create('password'))
user2 = Entity.create!(type: 'User', name: 'example', email: 'example@example.com', password_digest: BCrypt::Password.create('password'))

# Create Teams
team1 = Entity.create!(type: 'Team', name: 'Development Team')
team2 = Entity.create!(type: 'Team', name: 'Marketing Team')

# Create Stocks
stock1 = Entity.create!(type: 'Stock', name: 'Apple Inc.', symbol: 'AAPL')
stock2 = Entity.create!(type: 'Stock', name: 'Tesla Inc.', symbol: 'TSLA')

# Create Wallets
Wallet.create!(walletable: user1, balance: 1000.00)
Wallet.create!(walletable: user2, balance: 1000.00)
Wallet.create!(walletable: team1, balance: 1000.00)
Wallet.create!(walletable: team2, balance: 1000.00)
Wallet.create!(walletable: stock1, balance: 1000.00)
Wallet.create!(walletable: stock2, balance: 1000.00)

puts "Database seeded with initial data."