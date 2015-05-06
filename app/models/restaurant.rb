class Restaurant < ActiveRecord::Base
	has_many :menu_entries
	has_many :line_statuses
end
