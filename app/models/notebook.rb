class Notebook < ActiveRecord::Base
  belongs_to :user
  has_many :pages

  attr_accessible :name

  validates :user_id, presence: true

  def as_json
    super(include: :pages)
  end
end
