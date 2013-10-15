class Box < ActiveRecord::Base
  belongs_to :tab_group

  attr_accessible :name
end
