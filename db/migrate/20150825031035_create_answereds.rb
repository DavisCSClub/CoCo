class CreateAnswereds < ActiveRecord::Migration
  def change
    create_table :answereds do |t|
      t.integer :teamID
      t.integer :questionID

      t.timestamps null: false
    end
  end
end
