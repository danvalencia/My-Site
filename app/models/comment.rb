class Comment < ActiveRecord::Base
  attr_accessible :body, :parent_comment_id, :parent_post_id
  belongs_to :parent_post, :foreign_key => 'parent_post_id', :class_name => 'Post'
  belongs_to :parent_comment, :foreign_key => 'parent_comment_id', :class_name => 'Comment'
  has_many :child_comments, :foreign_key => 'parent_comment_id', :class_name => 'Comment'
  
  validates_presence_of :parent_post, :body, :email, :user
  validates_length_of   :email, minimum: 10, maximum: 50
  validates_length_of   :user, minimum: 8, maximum: 20
  validates_length_of   :website, minimum: 8, maximum: 50
end
