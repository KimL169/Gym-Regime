class RemoveGenderColumnFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :gender, :string
  end
end
