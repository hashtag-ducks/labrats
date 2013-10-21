class TabGroup < ActiveRecord::Base
  belongs_to :page
  has_many :boxes

  validates :page_id, presence: true

  def as_json
    super(include: :boxes)
  end
end
