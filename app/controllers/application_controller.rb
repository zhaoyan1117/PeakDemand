class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_current_user
    @user = current_user
  end
  
end
