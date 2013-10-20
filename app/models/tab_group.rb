class TabGroup < ActiveRecord::Base
  belongs_to :page
  has_many :box

  validates :page_id, presence: true
end
