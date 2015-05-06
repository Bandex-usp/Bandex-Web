class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :main_course
      t.string :meat
      t.string :second_course
      t.string :salad
      t.string :optional
      t.string :desert

      t.timestamps null: false
    end
  end
end
