class MenuEntry < ActiveRecord::Base
  belongs_to :restaurant
  
  def week_day
      (self.entry_date.wday-1)%7
  end
end
