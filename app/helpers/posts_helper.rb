module PostsHelper
  
  def render_error_messages
    html_output = ""
    if @post.errors.any?
      html_output += "<ul>"
      @post.errors.full_messages.each do |msg|
        html_output += "<li>#{msg}</li>"
      end
      html_output += "</ul>"
    end
    html_output.html_safe
  end
  
end
