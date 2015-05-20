class AddPinterestYoutubeToBoutiques < ActiveRecord::Migration
  def change
    add_column :boutiques, :you_tube, :string
    add_column :boutiques, :pinterest, :string
  end
end
