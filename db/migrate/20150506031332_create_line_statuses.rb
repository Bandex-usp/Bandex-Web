class CreateLineStatuses < ActiveRecord::Migration
  def change
    create_table :line_statuses do |t|
      t.datetime :submit_date
      t.integer :status
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
