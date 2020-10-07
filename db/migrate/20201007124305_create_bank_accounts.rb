class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts, id: :uuid do |t|
      t.string :IBAN
      t.string :SWIFT
      t.string :name
      t.string :number
      t.string :bank_name
      t.boolean :primary, default: false
      t.references :account_holder, polymorphic: true, null: false, type: :uuid, index: false

      t.timestamps
    end

    add_index :bank_accounts, %i[account_holder_id account_holder_type], name: :index_bank_accounts_on_account_holder
  end
end
