class AdminController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_current_user

  def index
  	@users

  end

  def enable_user
  end

  def disable_user
  end
end
