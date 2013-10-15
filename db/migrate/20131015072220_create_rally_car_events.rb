class CreateRallyCarEvents < ActiveRecord::Migration
  def change
    create_table :rally_car_events do |t|
      t.string :name,         length:   64, null: false, default: ""
      t.date   :beginning_on, null: false
      t.date   :end_on,       null: false
      t.text   :note,         length: 2048, default: ""

      t.timestamps
    end
  end
end
