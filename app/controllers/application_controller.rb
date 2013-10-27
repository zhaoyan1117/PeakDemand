class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_current_user
    @user = current_user
  end
  
  def create_date hash, date
    year = hash.delete "#{date}(#{1}i)"
    month = hash.delete "#{date}(#{2}i)"
    day = hash.delete "#{date}(#{3}i)"

    Date.new year.to_i, month.to_i, day.to_i
  end
  
end
