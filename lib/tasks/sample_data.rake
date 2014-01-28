

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    user = User.find(1)

    # counter = 0
    # lowerEx = ['squat', 'deadlift', 'RLD', 'calfraises', 'abs']
    # upperEx = ['bench', 'incline press', 'static hold', 'side raises', 'pull up', 'seated row']
    # workoutN = ['upper', 'lower']
    # reps = [8,9,10]
    # intensity = [4,5,6,7,8,9]
    # weight = [50,60,70]
    # daysCounter = 365

    # #populate workout logs
    # 365.times do
    #   counter = counter + 0.1
    #   daysCounter - 1
    #    w =  user.workouts.create!(name: workoutN.sample, created_at: daysCounter.days.ago)
    #    if w.name == 'upper'
    #       lowerEx.each do |exercise|
    #         w.exercises.create!(name: exercise, created_at: daysCounter.days.ago)
    #       end
    #   else 
    #       upperEx.each do |exercise|
    #         w.exercises.create!(name: exercise, created_at: daysCounter.days.ago)
    #       end
    #   end

    #   w.exercises.each do |exercise|
    #     weight.each do |w|
    #       exercise.segments.create!(weight:(w+counter), reps: (reps.sample), intensity: (intensity.sample), created_at: daysCounter.days.ago)
    #     end
    #   end
    # end


    counter = 0
    weight = 70
    bodyfat = 8
    kcal = [2000,2200,2300,2400,2500,2600]
    rand = [1,-1, -1.5, 1.5, 1.7, 1.8, 1.9,2]
    daysCounter = 365

    def bodylogcreate(user, weight, counter, kcal, bodyfat, daysCounter)
      user.bodylogs.create!(weight:(weight+counter).round(1), 
                            kcal: (kcal.sample + (counter*20)).to_i, 
                            bodyfat: (bodyfat+(counter/2)).round(1), 
                            created_at: daysCounter.days.ago)
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