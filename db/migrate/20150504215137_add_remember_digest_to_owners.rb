class AddRememberDigestToOwners < ActiveRecord::Migration
  def change
    add_column :owners, :remember_digest, :string
  end
end
