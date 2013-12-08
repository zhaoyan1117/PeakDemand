class UserMailer < ActionMailer::Base
  default :from => "peakdemand.saas@gmail.com"#"from@example.com"

  def generate_email(user,subject,to,body,sender,demand,url)
  	print "&&&&&&&&&&&&&&&&"
  	print url
  	@body = body
  	@sender_name = sender.name
  	@sender_email = sender.email

  	@demand_start = demand.start_at
  	@demand_end = demand.end_at
  	resource = demand.resource
  	@resource_name = resource.name
  	@resource_link = url
    mail(:reply_to  => user.email, 
    	 :to => to, 
    	 :subject => subject,) do |format|
    	format.html {render "generate_email"}
    end

    #red
  end
end
