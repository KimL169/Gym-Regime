class AddRatingColumnToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :rating, :integer
  end
end
