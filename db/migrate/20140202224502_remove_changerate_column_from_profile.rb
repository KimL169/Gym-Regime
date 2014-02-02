class RemoveChangerateColumnFromProfile < ActiveRecord::Migration
  def change
  	remove_column :profiles, :changerate, :integer
  end
end
