class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.float :weight
      t.integer :reps
      t.integer :intensity
      t.integer :exercise_id
      t.integer :workout_id

      t.timestamps
    end
  end
end
