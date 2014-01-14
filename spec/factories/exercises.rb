# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise do
    name "MyString"
    comment "MyString"
    workout_id 1
    user_id 1
  end
end
