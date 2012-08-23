class Comment < ActiveRecord::Base
  attr_accessible :body, :parent_comment_id, :parent_post_id
  belongs_to :parent_post, :foreign_key => 'parent_post_id', :class_name => 'Post'
  belongs_to :parent_comment, :foreign_key => 'parent_comment_id', :class_name => 'Comment'

  validates_presence_of :parent_post, :body
end
