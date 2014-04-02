class CreatePendingFriendships < ActiveRecord::Migration
  def change
    create_table :pending_friendships do |t|
      t.integer :user_id
      t.integer :from_user

      t.timestamps
    end
  end
end
