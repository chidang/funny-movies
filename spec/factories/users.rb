FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password '123456abc'
  end
end
