class RemoveTimeFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :time
  end
end
