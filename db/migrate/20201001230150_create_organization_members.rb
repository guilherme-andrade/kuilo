# frozen_string_literal: true

class CreateOrganizationMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_members, id: :uuid do |t|
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
