class TabGroup < ActiveRecord::Base
  belongs_to :page
  has_many :box
end
