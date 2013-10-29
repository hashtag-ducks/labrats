class RenameTextBoxTypes < ActiveRecord::Migration
  def up
    execute("UPDATE box_templates SET type = 'TextBoxTemplate' WHERE type = 'TextBox'")
  end

  def down
    execute("UPDATE box_templates SET type = 'TextBox' WHERE type = 'TextBoxTemplate'")
  end
end
