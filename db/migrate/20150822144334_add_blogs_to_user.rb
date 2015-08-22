class AddBlogsToUser < ActiveRecord::Migration
  def change
    add_column :users, :blogs, :text
  end
end
