class TabGroup < ActiveRecord::Base
  belongs_to :page
  has_many :boxes, dependent: :destroy

  attr_accessible :page_id

  validates :page_id, presence: true

  def as_json(options={})
    super(include: :boxes)
  end
end
