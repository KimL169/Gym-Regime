class RemoveActiviyColumnFromProfile < ActiveRecord::Migration
  def change
  	remove_column :profiles, :activiy
  end
end
