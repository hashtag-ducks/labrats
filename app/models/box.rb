class Box < ActiveRecord::Base
  belongs_to :box_template
  has_one :tab_group

  attr_accessible :name, :type

  delegate :notebook, :user, to: :tab_group

  validates :tab_group_id, presence: true

  def as_json(options={})
    super(methods: :type)
  end
end
