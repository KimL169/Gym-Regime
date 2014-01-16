class AddActivityColumnToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :activity, :integer
  end
end
