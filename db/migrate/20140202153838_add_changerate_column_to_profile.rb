class AddChangerateColumnToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :changerate, :integer
  end
end
