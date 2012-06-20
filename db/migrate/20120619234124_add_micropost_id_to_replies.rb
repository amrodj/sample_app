class AddMicropostIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :micropost_id, :integer
  end
end
