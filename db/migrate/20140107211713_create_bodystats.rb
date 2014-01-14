class CreateBodystats < ActiveRecord::Migration
  def change
    create_table :bodystats do |t|
      t.float :weight
      t.integer :kcal
      t.float :bodyfat
      t.integer :user_id

      t.timestamps
    end
  end
end
