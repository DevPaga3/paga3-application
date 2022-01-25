# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_24_183832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "adcs", force: :cascade do |t|
    t.bigint "factura_id"
    t.bigint "profile_id"
    t.string "reference"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["factura_id"], name: "index_adcs_on_factura_id"
    t.index ["profile_id"], name: "index_adcs_on_profile_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "cell_phone"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "role", default: 10, null: false
    t.string "email"
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "accountble_type"
    t.bigint "accountble_id"
    t.string "iban"
    t.string "account_number"
    t.bigint "bank_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["accountble_type", "accountble_id"], name: "index_bank_accounts_on_accountble_type_and_accountble_id"
    t.index ["bank_id"], name: "index_bank_accounts_on_bank_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "sigla"
    t.boolean "status", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "swift"
    t.string "website"
    t.string "slug"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "nif"
    t.string "address"
    t.string "cell_phone"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "status", default: true, null: false
    t.boolean "show_in_site", default: false, null: false
    t.string "email"
    t.bigint "category_id"
    t.string "accountNumber"
    t.string "iban"
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "configurations", force: :cascade do |t|
    t.string "name"
    t.string "cell_phone"
    t.string "email"
    t.string "address"
    t.string "nif"
    t.string "slug"
    t.integer "percentage_in_products"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "effort_rate", default: 40, null: false
    t.string "version", default: "V1.0.0", null: false
    t.string "nipc", default: "1234567890", null: false
    t.string "iec", default: "AO9834567890", null: false
    t.string "province", default: "", null: false
    t.string "municipality", default: "", null: false
  end

  create_table "facturas", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "lojista_id", null: false
    t.bigint "store_id"
    t.decimal "total_pagar", default: "0.0", null: false
    t.decimal "valor_restante", default: "0.0", null: false
    t.integer "numero_parcelas", default: 0, null: false
    t.integer "quantidade_produtos", default: 0, null: false
    t.integer "valor_mensal_pagar", default: 0, null: false
    t.datetime "data_ultimo_pagamento"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reference"
    t.index ["lojista_id"], name: "index_facturas_on_lojista_id"
    t.index ["store_id"], name: "index_facturas_on_store_id"
    t.index ["user_id"], name: "index_facturas_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "history_of_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "profile_id"
    t.decimal "purchase_amount", default: "0.0", null: false
    t.decimal "amount_to_discount", default: "0.0", null: false
    t.decimal "final_value", default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_credit", default: false, null: false
    t.index ["profile_id"], name: "index_history_of_profiles_on_profile_id"
    t.index ["user_id"], name: "index_history_of_profiles_on_user_id"
  end

  create_table "item_orders", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "pre_order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["pre_order_id"], name: "index_item_orders_on_pre_order_id"
    t.index ["product_id"], name: "index_item_orders_on_product_id"
  end

  create_table "itens_facturas", force: :cascade do |t|
    t.bigint "factura_id"
    t.string "name"
    t.decimal "real_price", default: "0.0", null: false
    t.integer "render_number", default: 0, null: false
    t.decimal "price_with_commission", default: "0.0", null: false
    t.decimal "commission_amount", default: "0.0", null: false
    t.string "slug"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["factura_id"], name: "index_itens_facturas_on_factura_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "quantity", default: 0, null: false
    t.boolean "send_to_companies", default: false, null: false
    t.boolean "send_to_customers", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "numbers"
  end

  create_table "moviments", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "user_id"
    t.boolean "is_credit", default: true, null: false
    t.decimal "amount", default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_moviments_on_profile_id"
    t.index ["user_id"], name: "index_moviments_on_user_id"
  end

  create_table "occupation_areas", force: :cascade do |t|
    t.string "occupation"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "status", default: true, null: false
  end

  create_table "partners", force: :cascade do |t|
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "pre_orders", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "store_id", null: false
    t.decimal "total_general", default: "0.0", null: false
    t.decimal "total_commission", default: "0.0", null: false
    t.decimal "total_without_commission", default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["profile_id"], name: "index_pre_orders_on_profile_id"
    t.index ["store_id"], name: "index_pre_orders_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price_with_commission", default: "0.0", null: false
    t.decimal "real_price", default: "0.0", null: false
    t.decimal "commission_amount", default: "0.0", null: false
    t.string "code"
    t.string "render_number", default: "3", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "description"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "bi"
    t.decimal "salary", default: "0.0", null: false
    t.string "position"
    t.string "company_name"
    t.string "address"
    t.datetime "birth"
    t.integer "status", default: 0, null: false
    t.integer "genre", default: 0, null: false
    t.boolean "have_credit", default: false, null: false
    t.decimal "amount_credit", default: "0.0", null: false
    t.decimal "percentage_valid", default: "0.0", null: false
    t.decimal "purchase_amount", default: "0.0", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "can_edit", default: false, null: false
    t.string "iban"
    t.string "account_number"
    t.bigint "bank_id"
    t.string "employer_address"
    t.integer "operating_sector", default: 0, null: false
    t.bigint "occupationArea_id"
    t.decimal "amount_to_discount"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "publicities", force: :cascade do |t|
    t.string "description"
    t.boolean "status"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchase_codes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "code"
    t.boolean "is_active", default: true, null: false
    t.datetime "expiration_at", default: "2021-03-27 18:46:47", null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_purchase_codes_on_user_id"
  end

  create_table "recibos", force: :cascade do |t|
    t.bigint "factura_id"
    t.decimal "valor", default: "0.0", null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["factura_id"], name: "index_recibos_on_factura_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "store"
    t.string "address"
    t.string "cell_phone"
    t.string "email"
    t.string "product"
    t.decimal "price", default: "0.0", null: false
    t.integer "render_number", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_requests_on_profile_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "reference_number"
    t.string "description"
    t.string "location"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_stores_on_category_id"
    t.index ["company_id"], name: "index_stores_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "cell_phone"
    t.integer "role", default: 0, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 1, null: false
    t.boolean "is_active", default: true, null: false
    t.string "slug"
    t.boolean "confirmation_terms", default: false, null: false
    t.string "full_name"
    t.boolean "confirmation_cell_phone", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adcs", "profiles"
  add_foreign_key "admins", "users"
  add_foreign_key "bank_accounts", "banks"
  add_foreign_key "companies", "categories"
  add_foreign_key "companies", "users"
  add_foreign_key "facturas", "stores"
  add_foreign_key "facturas", "users"
  add_foreign_key "facturas", "users", column: "lojista_id"
  add_foreign_key "history_of_profiles", "profiles"
  add_foreign_key "history_of_profiles", "users"
  add_foreign_key "item_orders", "pre_orders"
  add_foreign_key "item_orders", "products"
  add_foreign_key "itens_facturas", "facturas"
  add_foreign_key "moviments", "profiles"
  add_foreign_key "moviments", "users"
  add_foreign_key "pre_orders", "profiles"
  add_foreign_key "pre_orders", "stores"
  add_foreign_key "products", "stores"
  add_foreign_key "profiles", "users"
  add_foreign_key "purchase_codes", "users"
  add_foreign_key "recibos", "facturas"
  add_foreign_key "requests", "profiles"
  add_foreign_key "stores", "categories"
  add_foreign_key "stores", "companies"
end
