require 'redcarpet'

module Mysite

  class MarkdownService

    def convert_from_file(file_path)
      if File.file?(file_path)
        
        file = File.open(file_path)
        file_contents = file.read
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
              :autolink => true, :space_after_headers => true, :strikethrough => true, :superscript => true)    
        markdown.render file_contents
      end
    end
  end

end