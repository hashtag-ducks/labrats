class Box < ActiveRecord::Base
  belongs_to :tab_group

  attr_accessible :name

  validates :tab_group_id, presence: true
end
