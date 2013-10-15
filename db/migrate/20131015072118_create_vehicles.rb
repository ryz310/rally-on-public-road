class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.date_on :acquisition_date
      t.text :profile

      t.timestamps
    end
  end
end
