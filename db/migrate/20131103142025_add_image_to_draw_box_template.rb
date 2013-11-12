class AddImageToDrawBoxTemplate < ActiveRecord::Migration
  def change
    add_column :box_templates, :image, :binary
  end
end
