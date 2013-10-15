class CreatePrefectures < ActiveRecord::Migration
  def change
    create_table :prefectures do |t|
      t.string :name, length: 32, null: false, default: ""

      t.timestamps
    end
  end
end
