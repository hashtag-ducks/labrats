class PageTemplate < ActiveRecord::Base
  belongs_to :notebook
  has_many :tab_group_templates, dependent: :destroy

  delegate :owner, :users, to: :notebook

  attr_accessible :notebook_id

  validates :notebook_id, presence: true

  def as_json(options={})
    super(include: :tab_group_templates)
  end
end
