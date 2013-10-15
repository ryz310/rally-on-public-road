class CreateCheckPoints < ActiveRecord::Migration
  def change
    create_table :check_points do |t|
      t.belongs_to :event, index: true
      t.integer :number
      t.float :latitude
      t.float :longitude
      t.text :note

      t.timestamps
    end
  end
end
