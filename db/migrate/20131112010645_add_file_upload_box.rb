class AddFileUploadBox < ActiveRecord::Migration
  def change
    add_column :boxes, :file, :binary
    add_column :box_templates, :file, :binary
  end
end
