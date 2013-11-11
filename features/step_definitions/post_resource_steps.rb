require 'cucumber/rspec/doubles'
When /^(?:|I )press "(.*?)" to create resource$/ do |button|
	# stub_request(:post, "https://www.google.com/accounts/ClientLogin").
 #        with(:body => "Email=peakdemand.saas.test@gmail.com&Passwd=PeakDemand.CS169&source=GCal4Ruby&service=cl&accountType=HOSTED_OR_GOOGLE",
 #             :headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
 #        to_return(:status => 200, :body => "<entry xmlns='http://www.w3.org/2005/Atom' \n         xmlns:gd='http://schemas.google.com/g/2005' \n         xmlns:gCal='http://schemas.google.com/gCal/2005'>\n    <title type='text'></title>\n    <summary type='text'></summary>\n    <gCal:timezone value='America/Los_Angeles'></gCal:timezone>\n    <gCal:hidden value='false'></gCal:hidden>\n    <gCal:color value='#2952A3'></gCal:color>\n    <gd:where rel='' label='' valueString='Oakland'></gd:where>\n  </entry>", :headers => {})
    
 #    stub_request(:post, "http://www.google.com/calendar/feeds/default/owncalendars/full/").
 #        with(:body => "<entry xmlns:gCal='http://schemas.google.com/gCal/2005' xmlns:gd='http://schemas.google.com/g/2005' xmlns='http://www.w3.org/2005/Atom'>\n    <title type='text'>sample_resource_light</title>\n    <summary type='text'></summary>\n    <gCal:timezone value='America/Los_Angeles'/>\n    <gCal:hidden value='false'/>\n    <gCal:color value='#2952A3'/>\n    <gd:where label='' rel='' valueString='Oakland'/>\n  </entry>",
 #             :headers => {'Accept'=>'*/*', 'Authorization'=>'GoogleLogin auth=xmlns:gCal=\'http://schemas.google.com/gCal/2005\'>', 'Content-Type'=>'application/atom+xml', 'Gdata-Version'=>'2.1', 'User-Agent'=>'Ruby'}).
 #        to_return(:status => 200, :body => "", :headers => {})
    Resource.any_instance.stub(:create_calendar)
	#Resource.stub(:create_calendar)
	Resource.any_instance.stub(:get_url).and_return(mock('Google Calendar',:html_safe=>'This is a Google Calendar'))
	#Resource.should_receive :create_calendar
	click_button(button)

end