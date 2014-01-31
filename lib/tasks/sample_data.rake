

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    user = User.find_by(name: "richard")

    counter = 0
    daysCounter = 210


    def workoutscreate(user, counter, daysCounter)
      lowerEx = ['squat', 'deadlift', 'RLD']
      upperEx = ['bench', 'pull up', 'seated row']
      workoutN = ['upper', 'lower']
      reps = [8,9,10]
      intensity = [4,5,6,7,8,9]
      weight = [50,60,70]
      rate = [0.9, 0.8, 0.95,1.1, 1.2]

       w =  user.workouts.create(name: workoutN.sample, created_at: daysCounter.days.ago)
       if w.name == 'upper'
          lowerEx.each do |exercise|
            w.exercises.create(name: exercise, created_at: daysCounter.days.ago, strength: (80+(counter*rate.sample)).round(1))
            user.exercises.create(name: exercise, created_at: daysCounter.days.ago, strength: (80+(counter*rate.sample)).round(1))
          end
      else 
          upperEx.each do |exercise|
            w.exercises.create(name: exercise, created_at: daysCounter.days.ago, strength: (70+(counter*rate.sample)).round(1))
            user.exercises.create(name: exercise, created_at: daysCounter.days.ago, strength: (70+(counter*rate.sample)).round(1))
          end
      end
      w.exercises.each do |exercise|
        weight.each do |w|
          exercise.segments.create(weight: (w+counter).round(1), reps: (reps.sample), intensity: (intensity.sample), created_at: daysCounter.days.ago)
        end
      end
    end

    ######################
    #populate workout logs
    ######################
    90.times do
      counter = counter + 0.1
      daysCounter = daysCounter - 1
      workoutscreate(user, counter, daysCounter)
    end
    30.times do
      counter = counter - 0.03
      daysCounter = daysCounter - 1
      workoutscreate(user, counter, daysCounter)
    end
    60.times do
      counter = counter + 0.8
      daysCounter = daysCounter - 1
      workoutscreate(user, counter, daysCounter)
    end
    30.times do
      counter = counter - 0.04
      daysCounter = daysCounter - 1
      workoutscreate(user, counter, daysCounter)
    end


    counter = 0
    weight = 70
    bodyfat = 8
    kcalbulk = [2500,2700,2800,2600]
    kcalcut = [1800, 1900, 2000, 2100]
    rand = [1,-1, -1.5, 1.5, 1.7, 1.8, 1.9,2]
    daysCounter = 210

    def bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
      user.bodylogs.create!(weight:(weight+counter).round(1), 
                            kcal: (kcal.sample + (counter*20)).to_i, 
                            bodyfat: (bodyfat+(counter/2)).round(1), 
                            created_at: daysCounter.days.ago)
    end

    ###################
    #populate bodylogs
    ####################
    90.times do 

      counter = counter + (0.11*rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcalbulk, bodyfat, daysCounter)
    end
    30.times do
      counter = counter - (0.18*rand.sample)
      daysCounter = daysCounter - 1
       bodylogcreate(user, weight, counter, kcalcut, bodyfat, daysCounter)
    end
    60.times do
      counter = counter + (0.13 * rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcalbulk, bodyfat, daysCounter)
    end
    30.times do 
      counter = counter - (0.13* rand.sample)
      daysCounter = daysCounter - 1
      bodylogcreate(user, weight, counter, kcalcut, bodyfat, daysCounter)
    end
  #   30.times do 
  #     counter = counter - (0.15* rand.sample)
  #     daysCounter = daysCounter - 1
  #     bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
  #   end
  #    35.times do 
  #     counter = counter + (0.1* rand.sample)
  #     daysCounter = daysCounter - 1
  #     bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
  #   end   
  end
end