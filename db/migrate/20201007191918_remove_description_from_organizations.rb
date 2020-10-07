class RemoveDescriptionFromOrganizations < ActiveRecord::Migration[6.0]
  def change
    remove_column :organizations, :description, :text
  end
end
