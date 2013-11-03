class Notebook < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :page_templates, dependent: :destroy

  attr_accessible :name

  validates :owner_id, presence: true

  # Defining owner as a property lets us map the owner_id column in
  # the database (which is an integer) to the actual User model which
  # owns this notebook.
  def owner
    User.find(owner_id)
  end

  def owner=(user)
    self.owner_id = user.id
  end

  def owner?(user)
    owner == user
  end

  # Make this notebook accessible to the given user, and construct
  # their copy of the page-tab group-box tree.
  def add_user(user)
    users << user
    page_templates.each do |page_template|
      page = Page.new
      page.page_template = page_template
      page.user = user
      page.save
      page_template.tab_group_templates.each do |tab_group_template|
        tab_group = TabGroup.new
        tab_group.tab_group_template = tab_group_template
        tab_group.page_id = page.id
        tab_group.save
        tab_group_template.box_templates.each do |box_template|
          box = box_template.build_box
          box.tab_group_id = tab_group.id
          box.save
        end
      end
    end
    save
  end

  # Remove the given user's ability to access this notebook. Also
  # destroy their copy.
  def remove_user(user)
    users.delete user
    pages = page_templates.flat_map(&:pages).select { |p| p.user_id == user }
    pages.each(&:destroy)
    save
  end

  def as_json(options={})
    # This is jank, but apparently necessary to ensure that all the
    # right JSON is in all the right places. Bleh.
    user = options[:user]
    if owner?(user)
      return super(include:
                   { page_templates:
                     { include:
                       { tab_group_templates:
                         { include: { box_templates: { methods: :type } } }
                       }
                     }
                   })
    else
      pages = page_templates.flat_map(&:pages).select { |p| p.user == user }
      return super().merge({ pages: pages.map(&:as_json) })
    end
  end
end
