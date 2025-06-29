class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :property_type
      t.integer :price
      t.integer :bedrooms
      t.integer :bathrooms
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
