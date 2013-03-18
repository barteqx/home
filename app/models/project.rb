class Project < ActiveRecord::Base
  attr_accessible :content, :name, :short_description, :color, :tag_list, :user_id, :title
  acts_as_taggable
  has_many :comments
  belongs_to :user
  validates_presence_of :name, :short_description, :content, :color
  def title
  	name
  end
end
