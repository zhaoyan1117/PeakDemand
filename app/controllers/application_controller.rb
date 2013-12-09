class ApplicationController < ActionController::Base
  protect_from_forgery
	after_filter :store_location

  def get_current_user
    @user = current_user
  end

	def store_location
	  # store last url - this is needed for post-login redirect to whatever the user last visited.
	  if (request.fullpath != "/users/sign_in" &&
	      request.fullpath != "/users/sign_up" &&
	      request.fullpath != "/users/password" &&
	      !request.xhr?) # don't store ajax calls
	    session[:previous_url] = request.fullpath 
	  end
	end

	def after_sign_in_path_for(resource)
		last_path_or_root
	end
	
	def after_sign_out_path_for(resource)
		last_path_or_root
	end

	def after_update_path_for(resource)
		last_path_or_root
	end

  def after_sign_up_path_for(resource)
    last_path_or_root
  end

	def last_path_or_root
	  session[:previous_url] || root_path
	end

end
