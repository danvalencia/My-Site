require 'mysite/markdown_service'

class ResumeController < ApplicationController
  
  def index
    render_markdown_file "#{Rails.public_path}/resume.md"
  end

  def about
    render_markdown_file "#{Rails.public_path}/about.md"
  end

private

  def render_markdown_file(file)
    markdown_service = Mysite::MarkdownService.new
    @html_str = markdown_service.convert_from_file file
    render :default
  end

end