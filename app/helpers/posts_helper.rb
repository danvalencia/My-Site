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
  
  def render_comments_header
    html_output = ""
    actual_comments_size = @post.actual_comments.size
    if actual_comments_size > 0
      if actual_comments_size == 1 
        comments_string = "Comment"
      elsif actual_comments_size > 1
        comments_string = "Comments"
      end
      html_output = "<div>#{actual_comments_size} #{comments_string}</div>"
      html_output += "<hr id='comment_separator'>"
    end
    html_output.html_safe
  end
end
