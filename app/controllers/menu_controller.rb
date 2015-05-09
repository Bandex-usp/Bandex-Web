class MenuController < ApplicationController
	def index
		@restaurants = Restaurant.all
		@date = MenuEntry.last.entry_date
		@date = @date - ((@date.wday - 1)%7).days
	end
end
