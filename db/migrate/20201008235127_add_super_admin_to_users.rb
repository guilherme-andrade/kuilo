class AddSuperAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :super_admin, :boolean, default: false
  end
end
