class AddOrderings < ActiveRecord::Migration
  def up
    add_column :boxes, :ordering, :integer
    add_column :box_templates, :ordering, :integer
    add_column :tab_groups, :ordering, :integer
    add_column :tab_group_templates, :ordering, :integer

    # Add orderings to existing models. We'll just do this
    # arbitrarily; they'll be ordered by last update time (I think).
    PageTemplate.all.each do |page_template|
      tab_group_templates = page_template.tab_group_templates
      tab_group_templates.each_with_index do |tab_group_template, i|
        tab_group_template.ordering = i
        tab_group_template.save
      end
    end

    Page.all.each do |page|
      tab_groups = page.tab_groups
      tab_groups.each_with_index do |tab_group, i|
        tab_group.ordering = i
        tab_group.save
      end
    end

    TabGroupTemplate.all.each do |tab_group_template|
      box_templates = tab_group_template.box_templates
      box_templates.each_with_index do |box_template, i|
        box_template.ordering = i
        box_template.save
      end
    end

    TabGroup.all.each do |tab_group|
      boxes = tab_group.boxes
      boxes.each_with_index do |box, i|
        box.ordering = i
        box.save
      end
    end
  end

  def down
    remove_column :boxes, :ordering
    remove_column :box_templates, :ordering
    remove_column :tab_groups, :ordering
    remove_column :tab_group_templates, :ordering
  end
end
