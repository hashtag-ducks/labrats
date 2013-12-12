class AddPageOrdering < ActiveRecord::Migration
  def change
    add_column :pages, :ordering, :integer
    add_column :page_templates, :ordering, :integer

    # Add arbitrary default ordering.
    Notebook.all.each do |notebook|
      notebook.page_templates.each_with_index do |page_template, i|
        page_template.ordering = i
        page_template.save
        page_template.pages.each do |page|
          page.ordering = i
          page.save
        end
      end
    end
  end
end
