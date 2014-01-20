class AddStrengthColumnToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :strength, :float
  end
end
