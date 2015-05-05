class AddAdminToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :admin, :boolean, default: false
  end
end
