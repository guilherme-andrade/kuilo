class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :type
      t.monetize :amount
      t.references :rent, null: false, foreign_key: true, type: :uuid
      t.date :date
      t.references :bank_account, null: false, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
