class Notebook < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :pages, dependent: :destroy

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

  def as_json(options={})
    # This is jank, but apparently necessary to ensure that all the
    # right JSON is in all the right places. Bleh.
    json = super(include:
                 { pages:
                   { include:
                     { tab_groups:
                       { include: { boxes: { methods: :type } } }
                     }
                   }
                 })
    json[:is_owner] = options[:is_owner]
    return json
  end
end
