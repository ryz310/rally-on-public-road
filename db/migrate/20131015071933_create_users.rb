class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.date_on :birthday
      t.belongs_to :prefecture, index: true
      t.text :profile

      t.timestamps
    end
  end
end
