module PostsHelper
  
  def render_error_messages
    html_output = ""
    if @post.errors.any?
      html_output += "<div id='error_messages'>The following errors where found: <br/><ul>"
      @post.errors.full_messages.each do |msg|
        html_output += "<li>#{msg}</li>"
      end
      html_output += "</ul></div>"
    end
    html_output.html_safe
  end
  
end
