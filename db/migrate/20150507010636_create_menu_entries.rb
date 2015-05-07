class CreateMenuEntries < ActiveRecord::Migration
  def change
    create_table :menu_entries do |t|
      t.date :entry_date
      t.integer :period
      t.references :restaurant, index: true, foreign_key: true
      t.string :main
      t.string :meat
      t.string :second
      t.string :salad
      t.string :optional
      t.string :desert

      t.timestamps null: false
    end
  end
end
