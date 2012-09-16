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
end
