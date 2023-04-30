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

ActiveRecord::Schema[7.0].define(version: 2023_04_30_080014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "connection_id", null: false
    t.string "external_id", null: false
    t.string "nature", null: false
    t.decimal "balance", precision: 12, scale: 2, null: false
    t.string "currency_code", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "extra", default: {}, null: false
    t.index ["connection_id"], name: "index_accounts_on_connection_id"
    t.index ["external_id"], name: "index_accounts_on_external_id", unique: true
  end

  create_table "connection_sessions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "connect_url", null: false
    t.string "status", default: "pending", null: false
    t.datetime "expires_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_connection_sessions_on_customer_id"
    t.index ["status"], name: "index_connection_sessions_on_status"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "external_id", null: false
    t.string "secret", null: false
    t.string "provider_id"
    t.string "provider_code", null: false
    t.string "provider_name", null: false
    t.datetime "next_refresh_possible_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "status", null: false
    t.string "categorization"
    t.boolean "daily_refresh", null: false
    t.boolean "store_credentials", null: false
    t.string "country_code"
    t.datetime "last_success_at", precision: nil
    t.boolean "show_consent_confirmation", null: false
    t.string "last_consent_id"
    t.jsonb "last_attempt", default: {}, null: false
    t.index ["customer_id"], name: "index_connections_on_customer_id"
    t.index ["external_id"], name: "index_connections_on_external_id", unique: true
    t.index ["provider_code"], name: "index_connections_on_provider_code"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "identifier", null: false
    t.string "external_id", null: false
    t.string "secret", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_customers_on_external_id", unique: true
    t.index ["user_id"], name: "index_customers_on_user_id", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "external_id", null: false
    t.boolean "duplicated", null: false
    t.string "mode", null: false
    t.string "status", null: false
    t.date "made_on", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "currency_code", null: false
    t.string "description"
    t.string "category"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "extra", default: {}, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["external_id"], name: "index_transactions_on_external_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.string "customer_state", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "accounts", "connections"
  add_foreign_key "connection_sessions", "customers"
  add_foreign_key "connections", "customers"
  add_foreign_key "customers", "users"
  add_foreign_key "transactions", "accounts"
end
