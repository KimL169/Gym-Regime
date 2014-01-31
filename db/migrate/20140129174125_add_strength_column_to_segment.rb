class AddStrengthColumnToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :strength, :float
  end
end
