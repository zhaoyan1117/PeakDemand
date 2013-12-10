class UserMailer < ActionMailer::Base
  default :from => "peakdemand.saas@gmail.com"

  def send_to_consumer(user, mail, demand, resource_url)
  	@body,@sender_name,@sender_email,@demand_start,@demand_end,@resource_name,@resource_link = mail[:body], user.name, user.email, demand.start_at, demand.end_at, demand.resource.name, resource_url
    mail(:reply_to  => @sender_email, 
    	:to => mail[:to], 
      :cc => @sender_email,
    	:subject => "[PeakDemand] about #{@resource_name}",) { |format| format.html {render "generate_email_to_concumer"} }
  end

  def send_to_provider(user, mail, resource, resource_url)
    @body,@sender_name,@sender_email,@demand_start,@demand_end,@resource_name,@resource_link  = mail[:body],user.name,user.email,resource.start_at,resource.end_at,resource.name,resource_url

    mail(:reply_to  => @sender_email, 
      :to => mail[:to], 
      :cc => @sender_email,
      :subject => "[PeakDemand] about #{@resource_name}",) { |format| format.html {render "generate_email_to_provider"} }
  end

end
