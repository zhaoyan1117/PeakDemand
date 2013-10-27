# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :demand do
  	id 1
    start_at {Date.today}
    end_at {Date.tomorrow}
    intensity "LIGHT"
    description "this is a test demand"
    consumer {FactoryGirl.build :user, :is_consumer => true}
    resource {FactoryGirl.build :resource}
  end
end
