class AddGenderColumnToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :gender, :integer
  end
end
