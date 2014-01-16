class AddWeighttargetColumnToPorfile < ActiveRecord::Migration
  def change
    add_column :profiles, :weighttarget, :float
  end
end
