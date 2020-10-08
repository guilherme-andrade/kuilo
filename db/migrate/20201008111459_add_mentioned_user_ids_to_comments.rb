class AddMentionedUserIdsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :mentioned_user_ids, :jsonb, array: true, default: []
  end
end
