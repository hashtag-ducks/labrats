class Box < ActiveRecord::Base
  belongs_to :tab_group

  attr_accessible :name, :tab_group_id, :type

  validates :tab_group_id, presence: true

  # Need to let Backbone know what Box type to instantiate
  def as_json(options={})
    super(methods: :type)
  end
end
