class Meal < ActiveRecord::Base
	has_many :menu_entries
end
