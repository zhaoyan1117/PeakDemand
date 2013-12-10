class UserMailerController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_current_user

  def send_email_consumer
  	demand = Demand.find_by_id params[:mail][:demand_id]
  	url = resource_url(:id=>demand.resource.id)
    m = UserMailer.send_to_consumer(@user, params[:mail], demand, url).deliver
    flash[:notice] = "email sent!"
    redirect_to '/'
  end

  def send_email_provider
  end
end
