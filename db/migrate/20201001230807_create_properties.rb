# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties, id: :uuid do |t|
      t.string :name, default: ''
      t.string :code, default: ''
      t.references :owner, polymorphic: true, type: :uuid
      t.references :enterprise, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :creator_id
      t.string :manager_id
      t.integer :status, default: 0
      t.monetize :market_value, amount: { null: true, default: nil, limit: 8 }
      t.monetize :default_rent, amount: { null: true, default: nil, limit: 8 }
      t.monetize :default_charges, amount: { null: true, default: nil, limit: 8 }
      t.string :type
      t.integer :typology
      t.jsonb :characteristics
      t.integer :contracts_count, default: 0
      t.text :default_invoice_description
      t.text :default_charges_description
      t.datetime :contracts_last_updated_at
      t.datetime :current_contract_last_updated_at
      t.date :current_contract_start_date
      t.date :current_contract_end_date

      t.timestamps
    end

    add_index :properties, :creator_id
    add_index :properties, :manager_id
  end
end
