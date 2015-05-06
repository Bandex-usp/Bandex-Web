json.array!(@menu_entries) do |menu_entry|
  json.extract! menu_entry, :id, :meal_date, :period, :restaurant_id, :meal_id
  json.url menu_entry_url(menu_entry, format: :json)
end
