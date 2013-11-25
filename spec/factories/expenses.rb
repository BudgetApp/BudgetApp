# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    user_id 1
    category_id 1
    amount 1
  end
end
