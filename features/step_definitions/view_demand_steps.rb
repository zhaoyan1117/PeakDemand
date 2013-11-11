Then /^(?:|I )should (not )?see a calendar$/ do |is_not|
  condition = is_not ? 'no_' : ''
  if page.respond_to? :should
    page.should self.send("have_#{condition}content".to_sym, "Google Calendar")
  else
    assert page.send("has_#{condition}content?".to_sym, "Google Calendar")
  end
end