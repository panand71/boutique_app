class AddCommentsToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :comments, :text
  end
end
