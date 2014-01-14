class RenameOldTable < ActiveRecord::Migration
  def change
  	rename_table :bodystats, :bodylogs
  end
end
