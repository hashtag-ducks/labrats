class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :pages

  attr_accessible :name
end
