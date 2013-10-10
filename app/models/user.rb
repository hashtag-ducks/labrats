class User < ActiveRecord::Base
  attr_accessible :email, :name, :organization, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = user.email.downcase }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 10 }
  validates :password_confirmation, presence: true
end
