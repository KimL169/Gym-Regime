

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    user = User.find(1)

    counter = 0
    lowerEx = ['squat', 'deadlift', 'RLD', 'calfraises', 'abs']
    upperEx = ['bench', 'incline press', 'static hold', 'side raises', 'pull up', 'seated row']
    workoutN = ['upper', 'lower']
    reps = [8,9,10]
    intensity = [4,5,6,7,8,9]
    weight = [50,60,70,80]

    #populate workout logs
    50.times do
      counter = counter + 5
       w =  user.workouts.create!(name: workoutN.sample )
       if w.name == 'upper'
          lowerEx.each do |ex|
            w.exercises.create!(name: ex)
          end
      else
          upperEx.each do |ex|
            w.exercises.create!(name: ex)
          end
      end

      w.exercises.each do |ex|
        weight.each do |w|
          ex.segments.create!(weight:(w+counter), reps: (reps.sample), intensity: (intensity.sample))
        end
      end
    end


    counter = 0
    weight = 70
    bodyfat = 8
    kcal = [2000,2200,2300,2400,2500,2600]
    rand = [1,-1, -1.5, 1.5, 1.7, 1.8, 1.9,2]
    daysCounter = 365

    def bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
      user.bodylogs.create!(weight:(weight+counter), kcal: (kcal.sample + (counter*20)), bodyfat: (bodyfat+(counter/2)), created_at: daysCounter.days.ago)
    end

    #populate bodylogs
    90.times do 

      counter = counter + (0.11*rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
    end
    30.times do
      counter = counter - (0.18*rand.sample)
      daysCounter = daysCounter - 1
       bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
    end
    60.times do
      counter = counter + (0.13 * rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
    end
    30.times do 
      counter = counter - (0.13* rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
    end
    30.times do 
      counter = counter - (0.15* rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
    end
     35.times do 
      counter = counter + (0.1* rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
    end   
  end
end