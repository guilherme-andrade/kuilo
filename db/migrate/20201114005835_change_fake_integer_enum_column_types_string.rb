class ChangeFakeIntegerEnumColumnTypesString < ActiveRecord::Migration[6.0]
  def change
    change_column :contracts, :taxation_type, :string, default: ''
    change_column :contracts, :invoicing_frequency_unit, :string, default: ''
    change_column :properties, :typology, :string, default: ''
  end
end
