class AddFilledInModels < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.integer :page_template_id

      t.timestamps
    end

    create_table :tab_groups do |t|
      t.integer :page_id
      t.integer :tab_group_template_id

      t.timestamps
    end

    create_table :boxes do |t|
      t.integer :tab_group_id
      t.integer :box_template_id
      t.string :name
      t.text :content
      t.string :type

      t.timestamps
    end
  end
end
