class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :project_id, :post_id
  belongs_to :project
  belongs_to :post
  belongs_to :user
end
