class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :comment
      t.integer :workout_id
      t.integer :user_id

      t.timestamps
    end
  end
end
