require 'redcarpet'

class Post < ActiveRecord::Base
  attr_accessible :body, :excerpt, :title
  validates_presence_of :title, :excerpt, :body
  has_many :comments, :foreign_key => 'parent_post_id'
  
  def body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, :space_after_headers => true, :strikethrough => true, :superscript => true)    
    markdown.render read_attribute(:body)
  end
  
end
