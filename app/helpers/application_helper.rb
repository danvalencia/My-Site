module ApplicationHelper
	def login_link
		if user_signed_in?
			link_to('Logout', destroy_user_session_path, :method => :delete)
		else
			link_to('Login', new_user_session_path)
		end
	end

	def new_post_link
		if current_user.try("admin?")
			link_to "new post", {:controller => :posts, :action => :new} 
		end
	end

	def render_error_messages_for(model)
	  html_output = ""
	  if model.errors.any?
	    html_output += "<div id='error_messages'>The following errors where found: <br/><ul>"
	    model.errors.full_messages.each do |msg|
	      html_output += "<li>#{msg}</li>"
	    end
	    html_output += "</ul></div>"
	  end
	  html_output.html_safe
	end

	def prettify_date(date)
		if Time.now.year == date.year
			format = :no_year
		else
			format = :default
		end
		I18n.l date, :format => format
	end
end
