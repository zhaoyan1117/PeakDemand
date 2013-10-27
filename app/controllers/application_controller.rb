class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_current_user
    @user = current_user
  end
  
  def flatten_date_array hash, date
    %w(1 2 3).map do |e|
      result =  hash.delete "#{date}(#{e}i)"
      result.to_i
    end
  end
  
end
