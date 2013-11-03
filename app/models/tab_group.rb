class TabGroup < ActiveRecord::Base
  belongs_to :tab_group_template
  belongs_to :page
  has_many :boxes, dependent: :destroy

  delegate :notebook, :user, to: :page

  validates :page_id, presence: true

  def as_json(options={})
    super(include: :boxes)
  end
end
