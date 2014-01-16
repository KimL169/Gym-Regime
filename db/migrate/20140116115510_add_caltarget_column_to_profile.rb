class AddCaltargetColumnToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :caltarget, :integer
  end
end
