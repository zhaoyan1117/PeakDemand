# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	id 1
    name "User"
    email "user@test.com"
    password "peekdemandapp"
    password_confirmation "peekdemandapp"
    is_provider true
  end
end
