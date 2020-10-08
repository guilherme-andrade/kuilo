class AddInvoiceFieldsAndDefaultStatusToRents < ActiveRecord::Migration[6.0]
  def change
    change_column :rents, :status, :integer, default: 0
    add_column :rents, :invoice_description, :text
    add_column :rents, :charges_description, :text
  end
end
