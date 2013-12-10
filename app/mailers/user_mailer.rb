class UserMailer < ActionMailer::Base
  default :from => "peakdemand.saas@gmail.com"

  def send_to_consumer(user, mail, demand, resource_url)
  	@body = mail[:body]
    @sender_name = user.name
  	@sender_email = user.email
  	@demand_start = demand.start_at
  	@demand_end = demand.end_at
  	@resource_name = demand.resource.name
  	@resource_link = resource_url

    mail(:reply_to  => @sender_email, 
    	:to => mail[:to], 
      :cc => @sender_email,
    	:subject => "[PeakDemand] about #{@resource_name}",) do |format|
        format.html {render "generate_email_to_concumer"}
      end
  end

  def send_to_provider(user, mail, resource, resource_url)
    @body = mail[:body]
    @sender_name = user.name
    @sender_email = user.email
    @demand_start = resource.start_at
    @demand_end = resource.end_at
    @resource_name = resource.name
    @resource_link = resource_url

    mail(:reply_to  => @sender_email, 
      :to => mail[:to], 
      :cc => @sender_email,
      :subject => "[PeakDemand] about #{@resource_name}",) do |format|
        format.html {render "generate_email_to_provider"}
      end
  end

end
