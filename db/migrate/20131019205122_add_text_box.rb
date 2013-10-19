class AddTextBox < ActiveRecord::Migration
  def change
    add_column :boxes, :content, :text
    add_column :boxes, :type, :string
  end
end
