# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announcement do
    title "MyString"
    body "MyText"
    created_at "2013-12-08"
    creator {FactoryGirl.build :user, :is_administrator => true}
  end
end
