# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
  	id 1
    name "resource"
    description "this is test resource"
    start_at "2013-10-27"
    end_at "2013-10-28"
    provider nil
  end
end
