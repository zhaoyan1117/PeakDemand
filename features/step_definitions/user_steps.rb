Given(/^user "(.*?)" with email "(.*?)" and password "(.*?)" exsit$/) do |name, email,password|
  #pending # express the regexp above with the code you wish you had
  User.create!(:name=>name,:email=>email,:password=>password,:password_confirmation=>password)
end

Given(/^administrator "(.*?)" with email "(.*?)" and password "(.*?)" exist$/) do |name, email,password|
  #pending # express the regexp above with the code you wish you had
  User.create!(:name=>name,:email=>email,:password=>password,:password_confirmation=>password,:is_administrator=>true)
end

Given(/^provider "(.*?)" with email "(.*?)" and password "(.*?)" has signed up$/) do |name, email, password|
  step %{I am on the sign up page}
  step %{I push the selector ".signup"}
  within("div.sign_up_dropdown") do
    step %{I fill in "Name" with "#{name}"}
    step %{I fill in "Email" with "#{email}"}
    step %{I fill in "Password" with "#{password}"}
    step %{I fill in "Password Confirmation" with "#{password}"}
    step %{I check "user_is_provider"}
    step %{I press "Sign Up"}
  end
end

Given(/^consumer "(.*?)" with email "(.*?)" and password "(.*?)" has signed up$/) do |name, email, password|
  step %{I am on the sign up page}
  step %{I push the selector ".signup"}
  within("div.sign_up_dropdown") do
    step %{I fill in "Name" with "#{name}"}
    step %{I fill in "Email" with "#{email}"}
    step %{I fill in "Password" with "#{password}"}
    step %{I fill in "Password Confirmation" with "#{password}"}
    step %{I check "user_is_consumer"}
    step %{I press "Sign Up"}
  end
end

Given(/^user "(.*?)" with email "(.*?)" and password "(.*?)" has signed up$/) do |name, email, password|
  step %{I am on the sign up page}
  step %{I push the selector ".signup"}
  within("div.sign_up_dropdown") do
    step %{I fill in "Name" with "#{name}"}
    step %{I fill in "Email" with "#{email}"}
    step %{I fill in "Password" with "#{password}"}
    step %{I fill in "Password Confirmation" with "#{password}"}
    step %{I check "user_is_provider"}
    step %{I check "user_is_consumer"}
    step %{I press "Sign Up"}
  end
end

Given(/^user with email "(.*?)" and password "(.*?)" has signed in$/) do |email, password|
  step %{I am on the home page}
  step %{I push the selector ".login"}
  within("div.sign_in_dropdown") do
    step %{I fill in "Email" with "#{email}"}
    step %{I fill in "Password" with "#{password}"}
    step %{I press "Sign In"}
  end
end

Then(/^I sign in user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  within("div.sign_in_dropdown") do
    step %{I fill in "Email" with "#{email}"}
    step %{I fill in "Password" with "#{password}"}
    step %{I press "Sign In"}
  end
end

Then(/^inspect$/) do
  print page.body
end
