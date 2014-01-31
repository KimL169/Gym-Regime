class AddPrColumnToSegment < ActiveRecord::Migration
  def change
    add_column :segments, :pr, :integer
  end
end
