# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    user_id 1
    title "Sour Beer Master"
    body "Have at least 10 sour beers"
    is_private true
  end
end
