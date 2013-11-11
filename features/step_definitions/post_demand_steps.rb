When /^(?:|I )press "(.*?)" to create demand$/ do |button|
  Demand.any_instance.stub(:create_event)
  click_button(button)
end