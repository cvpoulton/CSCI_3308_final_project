class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :from_user
      t.text :message
      t.datetime :time

      t.timestamps
    end
  end
end
