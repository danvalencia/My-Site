require 'redcarpet'

class Post < ActiveRecord::Base
  attr_accessible :body, :excerpt, :title
  has_many :comments, :foreign_key => 'parent_post_id'
  validates_presence_of :title, :excerpt, :body
  validates_uniqueness_of :title

  def body_to_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, :space_after_headers => true, :strikethrough => true, :superscript => true)    
    markdown.render read_attribute(:body)
  end
 
  # Retrieves all direct child comments for this post.
  def get_all_child_comments
    Comment.where(:parent_post_id => id, :parent_comment_id => nil)
  end 

  def has_comments
    actual_comments.size > 0
  end

  def actual_comments
    comments.select{|c| c.id != nil}
  end
end
