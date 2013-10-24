class TabGroup < ActiveRecord::Base
  belongs_to :page
  has_many :boxes, dependent: :destroy

  delegate :notebook, to: :page
  delegate :owner, to: :notebook

  attr_accessible :page_id

  validates :page_id, presence: true

  def as_json(options={})
    super(include: :boxes)
  end
end
