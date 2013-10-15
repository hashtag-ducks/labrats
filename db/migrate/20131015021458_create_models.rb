class CreateModels < ActiveRecord::Migration
  def change
    create_table :tab_groups do |t|
      t.belongs_to :page

      t.timestamps
    end

    create_table :pages do |t|
      t.belongs_to :notebook

      t.timestamps
    end

    add_column :notebooks, :user_id, :integer
    add_column :boxes, :tab_group_id, :integer
  end
end
