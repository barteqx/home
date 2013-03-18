class Post < ActiveRecord::Base
  attr_accessible :content, :lead, :title, :tag_list, :user_id
  acts_as_taggable
  has_many :comments
  belongs_to :user
end
