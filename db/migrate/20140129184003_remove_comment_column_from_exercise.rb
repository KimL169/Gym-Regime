class RemoveCommentColumnFromExercise < ActiveRecord::Migration
  def change
  	remove_column :exercises, :comment, :string
  end
end
