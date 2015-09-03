class MenuController < ApplicationController
	def index
		@restaurants = Restaurant.all
		entry = MenuEntry.last
    @date = entry.entry_date unless entry.nil?
		@date = @date - ((@date.wday - 1)%7).days
	end
end
