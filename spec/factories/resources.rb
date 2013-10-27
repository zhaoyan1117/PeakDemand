# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource do
  	id 1
    name "resource"
    description "this is test resource"
    start_at {Date.today}
    end_at {Date.tomorrow}
    provider {FactoryGirl.build :user, :is_provider => true}
  end
end
