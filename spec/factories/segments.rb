# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :segment do
    weight 1.5
    reps 1
    intensity 1
    exercise_id 1
    workout_id 1
  end
end
