class Page < ActiveRecord::Base
  belongs_to :notebook
  has_many :tab_group

  validates :notebook_id, presence: true
end
