class AddCreatorToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :creator_id, :integer
    add_index :transactions, :creator_id
  end
end
