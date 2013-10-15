class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :name,       length: 32, null: false, default: ""
      t.date       :birthday
      t.belongs_to :prefecture, index: true
      t.text       :profile,    length: 2048, default: ""

      t.timestamps
    end
  end
end
