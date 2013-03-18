class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :login, :permissions
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :projects
  has_many :contacts
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password

  def admin?
  	self.permissions == "a"
  end
end