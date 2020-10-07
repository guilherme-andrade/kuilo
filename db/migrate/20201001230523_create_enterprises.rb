# frozen_string_literal: true

class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises, id: :uuid do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.string :creator_id
      t.string :manager_id
      t.integer :properties_count, default: 0
      t.integer :available_properties_count, default: 0

      t.timestamps
    end

    add_index :enterprises, :manager_id
    add_index :enterprises, :creator_id
  end
end
