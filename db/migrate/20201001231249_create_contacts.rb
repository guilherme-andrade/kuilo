# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :vat_number
      t.string :government_id
      t.string :name
      t.string :phone_number
      t.string :phone_country_code
      t.string :nationality_code
      t.string :email
      t.references :entity, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
