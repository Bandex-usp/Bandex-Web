class CreateMenuEntries < ActiveRecord::Migration
  def change
    create_table :menu_entries do |t|
      t.date :meal_date
      t.string :period
      t.references :restaurant, index: true, foreign_key: true
      t.references :meal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
