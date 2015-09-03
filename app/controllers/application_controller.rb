class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def period(datetime)
    datetime < (datetime.midday + 150.minutes) ? 0 : 1
  end
end
