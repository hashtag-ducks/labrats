class BoxTemplate < ActiveRecord::Base
  belongs_to :tab_group_template
  has_many :boxes

  attr_accessible :name, :tab_group_template_id, :type

  delegate :notebook, to: :tab_group_template
  delegate :owner, :users, to: :notebook

  validates :tab_group_template_id, presence: true

  # Ick. Gross? Maybe. Or cool. Not sure.
  #
  # Instantiate a real box from this template, setting its attributes
  # appropriately.
  def build_box
    box = eval(type.sub('Template', '')).new
    box.box_template = self
    box.class.accessible_attributes.each do |attr|
      box.assign_attributes({attr => self.send(attr)}) unless ['type', ''].include? attr
    end
    box
  end

  # Need to let Backbone know what Box type to instantiate
  def as_json(options={})
    super(methods: :type)
  end
end
