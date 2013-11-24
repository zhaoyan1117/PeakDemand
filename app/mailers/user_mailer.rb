class UserMailer < ActionMailer::Base
  default :from => "peakdemand.saas@gmail.com"#"from@example.com"

  def generate_email(user,subject,to,body)
    mail(:reply_to  => user.email, 
    	 :to => to, 
    	 :subject => subject, 
    	 :body=>body)
  end
end
