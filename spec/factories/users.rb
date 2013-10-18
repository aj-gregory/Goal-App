# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :username do
      Faker::Internet.user_name
    end
    password "ilovecats"
  end
end
