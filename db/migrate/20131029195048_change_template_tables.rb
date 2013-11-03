class ChangeTemplateTables < ActiveRecord::Migration
  def change
    rename_column :tab_group_templates, :page_id, :page_template_id
    rename_column :box_templates, :tab_group_id, :tab_group_template_id
  end
end
