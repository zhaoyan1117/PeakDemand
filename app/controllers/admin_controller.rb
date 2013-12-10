class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_current_user
  before_filter :check_admin

  def index
  	@unapproved_users = User.find_unapproved_users
  end

  def enable_user
  	u = User.approve params[:user_id]
  	u.save
  	flash[:notice] = "You just enabled user #{u.name}!"
  	redirect_to admin_index_url
  end

  private

  def check_admin
  	unless @user.is_admin?
  		flash[:error] = "You are not administrtor!"
	  	redirect_to '/' 
  	end
  end

end
