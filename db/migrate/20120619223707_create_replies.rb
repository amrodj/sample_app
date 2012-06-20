class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :content
      t.integer :micropost_id

      t.timestamps
    end
    add_index :replies, [:micropost_id, :created_at]
  end
end
