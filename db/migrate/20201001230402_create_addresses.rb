# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :street
      t.string :door
      t.string :floor
      t.string :city
      t.string :state
      t.string :country_code
      t.string :zip_code
      t.decimal :latitude
      t.decimal :longitude
      t.references :addressable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
