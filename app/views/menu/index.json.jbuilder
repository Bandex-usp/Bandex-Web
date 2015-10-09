json.array!(0..2) do |restaurant_id|
	json.restaurant_id restaurant_id
	entries = @restaurant_entries[restaurant_id]
	json.set! 'days' do
		json.array!(0..6) do |i|
			l_entry, d_entry = entries[i*2, 2]
			json.entry_date @date+i.days
			json.set! 'lunch' do
				json.extract! l_entry, :id, :main, :meat, :second, :salad, :optional, :desert, :calories, :raw unless l_entry.nil?
			end
			json.set! 'dinner' do
				json.extract! d_entry, :id, :main, :meat, :second, :salad, :optional, :desert, :calories, :raw unless d_entry.nil?
			end
		end
	end
end
