Given(/^user "(.*?)" with email "(.*?)" and password "(.*?)" exsit$/) do |name, email,password|
  #pending # express the regexp above with the code you wish you had
  User.create!(:name=>name,:email=>email,:password=>password,:password_confirmation=>password)
end

Given(/^provider "(.*?)" with email "(.*?)" and password "(.*?)" has signed up$/) do |name, email, password|
  step %{I am on the sign up page}
  step %{I fill in "Name" with "#{name}"}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I check "user_is_provider"}
  step %{I press "Sign up"}
end

Given(/^consumer "(.*?)" with email "(.*?)" and password "(.*?)" has signed up$/) do |name, email, password|
  step %{I am on the sign up page}
  step %{I fill in "Name" with "#{name}"}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I check "user_is_consumer"}
  step %{I press "Sign up"}
end

Given(/^user "(.*?)" with email "(.*?)" and password "(.*?)" has signed up$/) do |name, email, password|
  step %{I am on the sign up page}
  step %{I fill in "Name" with "#{name}"}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I check "user_is_provider"}
  step %{I check "user_is_consumer"}
  step %{I press "Sign up"}
end

Given(/^user with email "(.*?)" and password "(.*?)" has signed in$/) do |email, password|
  step %{I am on the home page}
  step %{I follow "Sign in"}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end

Then(/^I sign in user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end

Then(/^inspect$/) do
  print page.body
end
