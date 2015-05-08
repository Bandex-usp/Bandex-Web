json.array!(@menu_entries) do |menu_entry|
  json.extract! menu_entry, :id, :entry_date, :period, :main, :meat, :second, :salad, :optional, :desert
end
