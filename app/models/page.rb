class Page < ActiveRecord::Base
  belongs_to :notebook
  has_many :tab_groups, dependent: :destroy

  delegate :owner, to: :notebook

  attr_accessible :notebook_id

  validates :notebook_id, presence: true

  def as_json(options={})
    super(include: :tab_groups)
  end
end
