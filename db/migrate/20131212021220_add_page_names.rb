class AddPageNames < ActiveRecord::Migration
  def change
    add_column :pages, :name, :string

    Page.all.each do |page|
      page.name = "Page #{page.id}"
      page.save
    end

    add_column :page_templates, :name, :string

    PageTemplate.all.each do |page_template|
      page_template.name = "Page #{page_template.id}"
      page_template.save
    end
  end
end
