json.array!(@restaurants) do |restaurant|
	json.restaurant_id (restaurant.id - 1)
	json.set! 'days' do
		json.array!(0..6) do |i|
			json.entry_date @date+i.days
			json.set! 'lunch' do
				menu_entry = restaurant.menu_entries.where(entry_date:@date+i.days, period:0).first
				json.extract! menu_entry, :id, :main, :meat, :second, :salad, :optional, :desert, :raw if menu_entry
			end
			json.set! 'dinner' do
				menu_entry = restaurant.menu_entries.where(entry_date:@date+i.days, period:1).first
				json.extract! menu_entry, :id, :main, :meat, :second, :salad, :optional, :desert, :raw if menu_entry
			end
		end
	end
end
