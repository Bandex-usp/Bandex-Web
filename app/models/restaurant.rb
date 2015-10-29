class Restaurant < ActiveRecord::Base
	has_many :menu_entries
	has_many :line_statuses

  def self.lunch_openning
    Time.zone.parse("11:30")
  end

  def self.lunch_closing
    Time.zone.parse("14:20")
  end

  def self.diner_openning
    Time.zone.parse("17:30")
  end

  def self.diner_closing
    Time.zone.parse("19:45")
  end

  def self.openning(period)
    period == 0 ? lunch_openning : diner_openning
  end

  def self.closing(period)
    period == 0 ? lunch_closing : diner_closing
  end
end
