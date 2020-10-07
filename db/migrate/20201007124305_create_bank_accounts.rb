class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts, id: :uuid do |t|
      t.string :IBAN
      t.string :SWIFT
      t.string :name
      t.string :number
      t.string :bank_name
      t.boolean :primary, default: false
      t.references :owner, polymorphic: true, null: false, type: :uuid
      t.references :organization, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
