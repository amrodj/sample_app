class AddReplyCountToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :reply_cnt, :integer
  end
end
