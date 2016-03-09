class MenuController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @date = Date.today
    @date = @date - ((@date.wday - 1)%7).days
    @restaurant_entries = Array.new(@restaurants.count) { Array.new }
    all_entries = MenuEntry.where('entry_date BETWEEN ? AND ?', @date, @date+7.days).all
    all_entries.each do |e|
      @restaurant_entries[e.restaurant_id-1][e.week_day*2 + e.period] = e
    end
  end
end
