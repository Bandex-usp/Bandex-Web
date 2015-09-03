class Restaurant < ActiveRecord::Base
	has_many :menu_entries
	has_many :line_statuses

  def self.lunch_openning
    DateTime.parse("11:30")
  end

  def self.lunch_closing
    DateTime.parse("14:15")
  end

  def self.diner_openning
    DateTime.parse("17:30")
  end

  def self.diner_closing
    DateTime.parse("19:45")
  end

  def self.openning(period)
    period == 0 ? lunch_openning : diner_openning
  end

  def self.closing(period)
    period == 0 ? lunch_closing : diner_closing
  end
end
