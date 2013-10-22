class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy

  attr_accessible :name

  validates :user_id, presence: true

  def as_json(options={})
    # This is jank, but apparently necessary to ensure that all the
    # right JSON is in all the right places. Bleh.
    super(include:
          { pages:
            { include:
              { tab_groups:
                { include: { boxes: { methods: :type } } }
              }
            }
          })
  end
end
