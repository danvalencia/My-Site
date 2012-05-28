require 'redcarpet'

class Post < ActiveRecord::Base
  attr_accessible :body, :excerpt, :title
  validates_presence_of :title, :body
  
  def body
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, :space_after_headers => true, :strikethrough => true, :superscript => true)    
    markdown.render read_attribute(:body)
  end
  
end
