class Page < ActiveRecord::Base
  belongs_to :page_template
  belongs_to :user
  has_many :tab_groups, dependent: :destroy

  delegate :notebook, to: :page_template

  attr_accessible :name, :ordering

  validates :page_template_id, presence: true

  def as_json(options={})
    super(include:
          { tab_groups:
            { include: { boxes: { methods: :type } } }
          })
  end
end
