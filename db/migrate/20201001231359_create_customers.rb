# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers, id: :uuid do |t|
      t.string :creator_id
      t.string :account_manager_id
      t.string :type
      t.string :name
      t.integer :status
      t.integer :contracts_count, default: 0
      t.integer :properties_count, default: 0
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :customers, :creator_id
    add_index :customers, :account_manager_id
  end
end
