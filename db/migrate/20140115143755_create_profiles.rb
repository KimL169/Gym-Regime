class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :age
      t.integer :height
      t.string :gender
      t.integer :user_id
      t.timestamps
    end
  end
end
