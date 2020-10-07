# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :owner_id
      t.integer :properties_count, default: 0
      t.integer :enterprises_count, default: 0
      t.integer :members_count, default: 0
      t.integer :default_rent_due_day, default: 1

      t.timestamps
    end

    add_index :organizations, :owner_id
  end
end
