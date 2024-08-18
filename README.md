# README

Welcome to the Wallet System project! This is a Ruby on Rails application designed to manage wallets, transactions, and users, along with a comprehensive set of features for handling financial transactions and relationships.

# Installation
  * Clone the repository:
  * Install dependencies:
    ```sh
      bundle install
    ```
  * Setup the database::
    ```sh
      rails db:create
      rails db:migrate
      rails db:seed
    ```
# API Endpoints

- login
Example curl of Login :
```sh
  curl --location --request POST 'http://localhost:3000/api/login' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": {{email}},
    "password": {{password}}
  }'
```

- Transfer
Example curl of Transfer
```sh
  curl --location --request POST 'http://localhost:3000/api/wallets/transfer' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: {{token}}' \
  --data-raw '{
      "amount": {{ammount}},
      "transaction_type": {{debit/credit}},
      "target_wallet_id": {{walletid}}
  }'
```