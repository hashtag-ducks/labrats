class Box < ActiveRecord::Base
  belongs_to :box_template
  belongs_to :tab_group

  attr_accessible :name, :type, :order

  delegate :notebook, :user, to: :tab_group

  validates :tab_group_id, presence: true

  def as_json(options={})
    super(methods: :type)
  end
end
