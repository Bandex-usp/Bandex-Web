class AddCaloriesToMenuEntry < ActiveRecord::Migration
  def change
    add_column :menu_entries, :calories, :int
  end
end
