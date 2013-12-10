class UserMailerController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_current_user

  def send_email_consumer
  	demand = Demand.find_by_id params[:mail][:demand_id]
  	url = resource_url(:id=>demand.resource.id)
    m = UserMailer.send_to_consumer(@user, params[:mail], demand, url).deliver
    render :json => {:msg => 'Your email has been sent successfully!'}
  end

  def send_email_provider
    resource = Resource.find_by_id params[:mail][:resource_id]
    url = resource_url(:id=>resource.id)
    m = UserMailer.send_to_provider(@user, params[:mail], resource, url).deliver
    render :json => {:msg => 'Your email has been sent successfully!'}
  end
end
