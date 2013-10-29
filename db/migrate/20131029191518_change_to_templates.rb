class ChangeToTemplates < ActiveRecord::Migration
  def change
    rename_table :pages, :page_templates
    rename_table :tab_groups, :tab_group_templates
    rename_table :boxes, :box_templates
  end
end
