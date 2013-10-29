class Page < ActiveRecord::Base
  belongs_to :page_template
  belongs_to :user
  has_many :tab_groups, dependent: :destroy

  delegate :notebook, to: :page_template

  validates :page_template_id, presence: true

  def as_json(options={})
    super(include: :tab_groups)
  end
end
