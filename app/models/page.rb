class Page < ActiveRecord::Base
  belongs_to :notebook
  has_many :tab_group

  attr_accessible :notebook_id

  validates :notebook_id, presence: true
end
