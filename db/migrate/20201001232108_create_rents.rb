# frozen_string_literal: true

class CreateRents < ActiveRecord::Migration[6.0]
  def change
    create_table :rents, id: :uuid do |t|
      t.references :contract, null: false, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.monetize :amount
      t.monetize :discount
      t.monetize :charges
      t.date :issue_date
      t.date :due_date
      t.date :incidence_period_start
      t.date :incidence_period_end
      t.string :invoice_number
      t.integer :status

      t.timestamps
    end
  end
end
