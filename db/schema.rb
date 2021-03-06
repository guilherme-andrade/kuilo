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

ActiveRecord::Schema.define(version: 2020_11_15_024403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "street"
    t.string "door"
    t.string "floor"
    t.string "city"
    t.string "state"
    t.string "country_code"
    t.string "zip_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "addressable_type", null: false
    t.uuid "addressable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "ahoy_messages", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.text "to"
    t.string "mailer"
    t.text "subject"
    t.datetime "sent_at"
    t.index ["user_type", "user_id"], name: "index_ahoy_messages_on_user_type_and_user_id"
  end

  create_table "bank_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "IBAN"
    t.string "SWIFT"
    t.string "name"
    t.string "number"
    t.string "bank_name"
    t.boolean "primary", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "account_holder_type"
    t.uuid "account_holder_id"
    t.index ["account_holder_id", "account_holder_type"], name: "index_bank_accounts_on_account_holder"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "commentable_type", null: false
    t.uuid "commentable_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "mentioned_user_ids", default: [], array: true
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "vat_number"
    t.string "government_id"
    t.string "name"
    t.string "phone_number"
    t.string "phone_country_code"
    t.string "nationality_code"
    t.string "email"
    t.string "entity_type", null: false
    t.uuid "entity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_type", "entity_id"], name: "index_contacts_on_entity_type_and_entity_id"
  end

  create_table "contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "customer_id", null: false
    t.uuid "property_id", null: false
    t.uuid "organization_id", null: false
    t.string "occupied_property_id"
    t.string "creator_id"
    t.string "manager_id"
    t.date "start_date"
    t.date "end_date"
    t.date "renegotiation_period_start_date"
    t.date "renegotiation_period_end_date"
    t.integer "rent_due_day"
    t.integer "status", default: 0
    t.integer "rent_amount_cents", default: 0, null: false
    t.string "rent_amount_currency", default: "EUR", null: false
    t.integer "rent_charges_cents", default: 0, null: false
    t.string "rent_charges_currency", default: "EUR", null: false
    t.string "taxation_type", default: ""
    t.text "charges_description"
    t.text "invoice_description"
    t.integer "invoicing_frequency_value", default: 1
    t.string "invoicing_frequency_unit", default: ""
    t.integer "deposit_rent_multiplier", default: 2
    t.boolean "deposit_paid", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_contracts_on_creator_id"
    t.index ["customer_id"], name: "index_contracts_on_customer_id"
    t.index ["manager_id"], name: "index_contracts_on_manager_id"
    t.index ["occupied_property_id"], name: "index_contracts_on_occupied_property_id"
    t.index ["organization_id"], name: "index_contracts_on_organization_id"
    t.index ["property_id"], name: "index_contracts_on_property_id"
  end

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "creator_id"
    t.string "account_manager_id"
    t.string "type"
    t.string "name"
    t.integer "status"
    t.integer "contracts_count", default: 0
    t.integer "properties_count", default: 0
    t.uuid "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_manager_id"], name: "index_customers_on_account_manager_id"
    t.index ["creator_id"], name: "index_customers_on_creator_id"
    t.index ["organization_id"], name: "index_customers_on_organization_id"
  end

  create_table "enterprises", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "organization_id", null: false
    t.string "creator_id"
    t.string "manager_id"
    t.integer "properties_count", default: 0
    t.integer "available_properties_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_enterprises_on_creator_id"
    t.index ["manager_id"], name: "index_enterprises_on_manager_id"
    t.index ["organization_id"], name: "index_enterprises_on_organization_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "recipient_type", null: false
    t.uuid "recipient_id", null: false
    t.string "notifiable_type"
    t.uuid "notifiable_id"
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient_type_and_recipient_id"
  end

  create_table "organization_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "user_id", null: false
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_organization_members_on_organization_id"
    t.index ["user_id"], name: "index_organization_members_on_user_id"
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "owner_id"
    t.integer "properties_count", default: 0
    t.integer "enterprises_count", default: 0
    t.integer "members_count", default: 0
    t.integer "default_rent_due_day", default: 1
    t.integer "default_rent_issuing_day", default: 15
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_organizations_on_owner_id"
  end

  create_table "properties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.string "code", default: ""
    t.string "owner_type"
    t.uuid "owner_id"
    t.uuid "enterprise_id"
    t.uuid "organization_id", null: false
    t.string "creator_id"
    t.string "manager_id"
    t.integer "status", default: 0
    t.bigint "market_value_cents"
    t.string "market_value_currency", default: "EUR", null: false
    t.bigint "default_rent_cents"
    t.string "default_rent_currency", default: "EUR", null: false
    t.bigint "default_charges_cents"
    t.string "default_charges_currency", default: "EUR", null: false
    t.string "type"
    t.string "typology", default: ""
    t.jsonb "characteristics"
    t.integer "contracts_count", default: 0
    t.text "default_invoice_description"
    t.text "default_charges_description"
    t.datetime "contracts_last_updated_at"
    t.datetime "current_contract_last_updated_at"
    t.date "current_contract_start_date"
    t.date "current_contract_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_properties_on_creator_id"
    t.index ["enterprise_id"], name: "index_properties_on_enterprise_id"
    t.index ["manager_id"], name: "index_properties_on_manager_id"
    t.index ["organization_id"], name: "index_properties_on_organization_id"
    t.index ["owner_type", "owner_id"], name: "index_properties_on_owner_type_and_owner_id"
  end

  create_table "rents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contract_id", null: false
    t.uuid "organization_id", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.integer "discount_cents", default: 0, null: false
    t.string "discount_currency", default: "EUR", null: false
    t.integer "charges_cents", default: 0, null: false
    t.string "charges_currency", default: "EUR", null: false
    t.date "issue_date"
    t.date "due_date"
    t.date "incidence_period_start"
    t.date "incidence_period_end"
    t.string "invoice_number"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "invoice_description"
    t.text "charges_description"
    t.index ["contract_id"], name: "index_rents_on_contract_id"
    t.index ["organization_id"], name: "index_rents_on_organization_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.uuid "rent_id", null: false
    t.date "date"
    t.uuid "bank_account_id", null: false
    t.uuid "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "creator_id"
    t.index ["bank_account_id"], name: "index_transactions_on_bank_account_id"
    t.index ["creator_id"], name: "index_transactions_on_creator_id"
    t.index ["organization_id"], name: "index_transactions_on_organization_id"
    t.index ["rent_id"], name: "index_transactions_on_rent_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
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
    t.integer "properties_count", default: 0
    t.integer "memberships_count", default: 0
    t.integer "managed_enterprises_count", default: 0
    t.integer "created_enterprises_count", default: 0
    t.integer "owned_organizations_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.uuid "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "super_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "contracts", "customers"
  add_foreign_key "contracts", "organizations"
  add_foreign_key "contracts", "properties"
  add_foreign_key "customers", "organizations"
  add_foreign_key "enterprises", "organizations"
  add_foreign_key "organization_members", "organizations"
  add_foreign_key "organization_members", "users"
  add_foreign_key "properties", "enterprises"
  add_foreign_key "properties", "organizations"
  add_foreign_key "rents", "contracts"
  add_foreign_key "rents", "organizations"
  add_foreign_key "transactions", "bank_accounts"
  add_foreign_key "transactions", "organizations"
  add_foreign_key "transactions", "rents"
end
