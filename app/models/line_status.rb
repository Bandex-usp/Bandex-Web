class LineStatus < ActiveRecord::Base
  belongs_to :restaurant

  def period
    submit_date < (submit_date.midday + 150.minutes) ? 0 : 1
  end
end
