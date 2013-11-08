# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	id 1
    name "User"
    email "user@test.com"
    password "peakdemandapp"
    password_confirmation "peakdemandapp"
    is_provider true
  end
end
