class AddChangerateColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :changerate, :float
  end
end
