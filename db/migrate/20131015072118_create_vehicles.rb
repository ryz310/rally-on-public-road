class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.belongs_to :user,              index: true, null: false
      t.string     :name,              length: 128, null: false, default: ""
      t.date       :acquisition_date
      t.text       :profile,           length: 2048, default: ""

      t.timestamps
    end
  end
end
