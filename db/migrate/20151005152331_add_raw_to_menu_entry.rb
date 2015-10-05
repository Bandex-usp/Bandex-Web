class AddRawToMenuEntry < ActiveRecord::Migration
  def change
    add_column :menu_entries, :raw, :string
  end
end
