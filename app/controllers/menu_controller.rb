class MenuController < ApplicationController
	def index
		@restaurants = Restaurant.all
		@date = MenuEntry.where(restaurant_id:1).last.entry_date - 6.days
	end
end
