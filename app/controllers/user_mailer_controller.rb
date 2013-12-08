class UserMailerController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_current_user

  def send_email
  	demand_id = 1
  	demand = Demand.find_by_id(demand_id)
  	url = resource_url(:id=>demand.resource.id)
  	print "^^^^^^^^^^^^"
  	print url
    m = UserMailer.generate_email(@user, 'PeekDemand.com',params[:mail][:to], params[:mail][:body],@user,demand, url).deliver
    flash[:notice] = "email sent!"
    redirect_to '/'
  end
end
