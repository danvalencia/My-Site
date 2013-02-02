require 'redcarpet'

class Post < ActiveRecord::Base
  attr_accessible :body, :excerpt, :title, :comments_disabled
  has_many :comments, :foreign_key => 'parent_post_id'
  belongs_to :author, :class_name => "User", :foreign_key => 'user_id'
  validates_presence_of :title, :excerpt, :body, :user_id
  validates :title, :length => { :maximum => 35 }
  validates_uniqueness_of :title
  before_create :set_friendly_url

  def set_friendly_url
    self.friendly_url = self.title.gsub(" ", "_").downcase unless self.title.nil?
  end

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
