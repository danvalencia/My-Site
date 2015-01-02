require 'redcarpet'

class ResumeController < ApplicationController

  def index
    resume = File.open("#{Rails.public_path}/resume.md")
    resume_string = resume.read

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, :space_after_headers => true, :strikethrough => true, :superscript => true)    
    @resume_html = markdown.render resume_string
  end

end