class CreateBoutiqueSearches < ActiveRecord::Migration
  def change
    create_table :boutique_searches do |t|
      t.string :keywords
      t.integer :boutique_id
      t.string :boutique_name
      t.string :category
      t.string :city
      t.string :state
      t.string :new
      t.string :show

      t.timestamps null: false
    end
  end
end
