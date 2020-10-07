# frozen_string_literal: true

class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts, id: :uuid do |t|
      t.references :customer, null: false, foreign_key: true, type: :uuid
      t.references :property, null: false, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :occupied_property_id
      t.string :creator_id
      t.string :manager_id
      t.date :start_date
      t.date :end_date
      t.date :renegotiation_period_start_date
      t.date :renegotiation_period_end_date
      t.integer :rent_due_day
      t.integer :status, default: 0
      t.monetize :rent_amount
      t.monetize :rent_charges
      t.integer :taxation_type, default: 0
      t.text :charges_description
      t.text :invoice_description
      t.integer :invoicing_frequency_value, default: 1
      t.integer :invoicing_frequency_unit, default: 0
      t.integer :deposit_rent_multiplier, default: 2
      t.boolean :deposit_paid, default: false

      t.timestamps
    end

    add_index :contracts, :occupied_property_id
    add_index :contracts, :creator_id
    add_index :contracts, :manager_id
  end
end
