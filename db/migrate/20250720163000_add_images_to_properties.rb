class AddImagesToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :images, :text
  end
end