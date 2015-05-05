class CreateBoutiques < ActiveRecord::Migration
  def change
    create_table :boutiques do |t|
      t.string :name
      t.string :website
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :email
      t.string :city
      t.string :state
      t.text :schedule
      t.string :category
      t.text :description
      t.references :owner, index: true, foreign_key: true

      t.timestamps null: false
    end
      add_index :boutiques, [:owner_id, :created_at]
  end
end
