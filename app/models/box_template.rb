class BoxTemplate < ActiveRecord::Base
  belongs_to :tab_group_template
  has_many :boxes

  attr_accessible :name, :tab_group_template_id, :type

  delegate :notebook, to: :tab_group_template
  delegate :owner, :users, to: :notebook

  validates :tab_group_template_id, presence: true

  # Need to let Backbone know what Box type to instantiate
  def as_json(options={})
    super(methods: :type)
  end
end
