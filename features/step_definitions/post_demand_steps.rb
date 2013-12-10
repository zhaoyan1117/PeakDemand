When /^(?:|I )press "(.*?)" to create demand$/ do |button|
  Demand.any_instance.stub(:create_event)
  click_button(button)
end

Then(/^I press "(.*?)" to create demand with in "(.*?)"$/) do |button, arg2|
  Demand.any_instance.stub(:create_event)
  within(arg2) do
	click_button(button)
  end
end