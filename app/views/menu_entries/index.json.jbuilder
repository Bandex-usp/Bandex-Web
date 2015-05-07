json.array!(@menu_entries) do |menu_entry|
  json.extract! menu_entry, :id, :entry_date, :period, :restaurant_id, :main, :meat, :second, :salad, :optional, :desert
  json.url menu_entry_url(menu_entry, format: :json)
end
