class AddDrawBox < ActiveRecord::Migration
  def change
    add_column :boxes, :image, :binary
  end
end
