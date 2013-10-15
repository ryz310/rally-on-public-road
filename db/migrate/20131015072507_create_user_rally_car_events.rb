class CreateUserRallyCarEvents < ActiveRecord::Migration
  def change
    create_table :user_rally_car_events do |t|
      t.belongs_to :user,         null: false
      t.belongs_to :event,        null: false
      t.date       :beginning_on, null: false
      t.date       :end_on
      t.text       :note,         length: 2048, default: ""

      t.timestamps
    end
  end
end
