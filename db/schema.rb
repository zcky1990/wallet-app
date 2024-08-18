# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_18_055619) do
  create_table "entities", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.datetime "token_expires_at"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_entities_on_email", unique: true
    t.index ["type"], name: "index_entities_on_type"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "wallet_id", null: false
    t.integer "target_wallet_id"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "transaction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_wallet_id"], name: "index_transactions_on_target_wallet_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "walletable_type", null: false
    t.integer "walletable_id", null: false
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["walletable_type", "walletable_id"], name: "index_wallets_on_walletable"
    t.index ["walletable_type", "walletable_id"], name: "index_wallets_on_walletable_type_and_walletable_id"
  end

  add_foreign_key "transactions", "wallets"
  add_foreign_key "transactions", "wallets", column: "target_wallet_id"
end
