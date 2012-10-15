module ApplicationHelper
	SOCIAL_LINKS_MAP = {
		:twitter => "https://twitter.com/_DanValencia",
		:linkedin => "http://www.linkedin.com/in/danvalencia"
	}


	def login_link
		if user_signed_in?
			link_to('Logout', destroy_user_session_path, :method => :delete)
		else
			link_to('Login', new_user_session_path)
		end
	end

	def new_post_link
		if current_user.try("admin?")
			link_to "new post", new_post_path
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

	def render_social_links
		html_output = "<span id='social_links'>"
		SOCIAL_LINKS_MAP.each do |k,v|
			tag = "<a href='#{v}'>"
			tag += "<%= image_tag '#{k}.png' %>"
			tag += "</a>"
			html_output += tag
		end
		html_output = "</span>"
		html_output.html_safe
	end
end
