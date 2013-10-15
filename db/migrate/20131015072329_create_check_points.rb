class CreateCheckPoints < ActiveRecord::Migration
  def change
    create_table :check_points do |t|
      t.belongs_to :event,     null: false,  index: true
      t.integer    :number,    null: false,  default: 1
      t.float      :latitude,  null: false,  default: 0.0
      t.float      :longitude, null: false,  default: 0.0
      t.text       :note,      length: 2048, default: ""

      t.timestamps
    end
  end
end
