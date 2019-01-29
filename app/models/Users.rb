class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true

  def slug
    self.username.parameterize
  end

  def self.find_by_slug(str)
    User.find_by_username(str.gsub("-", " "))
  end
 end