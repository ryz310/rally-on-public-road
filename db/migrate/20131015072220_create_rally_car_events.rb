class CreateRallyCarEvents < ActiveRecord::Migration
  def change
    create_table :rally_car_events do |t|
      t.string :name
      t.date :beginning_on
      t.date :end_on
      t.text :note

      t.timestamps
    end
  end
end
