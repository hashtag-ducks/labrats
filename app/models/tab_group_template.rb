class TabGroupTemplate < ActiveRecord::Base
  belongs_to :page_template
  has_many :box_templates, dependent: :destroy
  has_many :tab_groups

  delegate :notebook, to: :page_template
  delegate :owner, :users, to: :notebook

  attr_accessible :page_template_id, :order

  validates :page_template_id, presence: true

  def as_json(options={})
    super(include: :box_templates)
  end
end
