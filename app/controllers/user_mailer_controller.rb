class UserMailerController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_current_user

  def send_email
    m = UserMailer.generate_email(@user, params[:mail][:subject],params[:mail][:to], params[:mail][:body]).deliver
    flash[:notice] = "email sent!"
    redirect_to '/'
  end
end
