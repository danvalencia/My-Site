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
  
end
