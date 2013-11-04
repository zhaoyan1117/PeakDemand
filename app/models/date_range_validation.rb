module DateRangeValidation
  
  extend ActiveSupport::Concern

  included do
    validate :validate_start_cannot_be_later_than_end
  end

  private

  def validate_start_cannot_be_later_than_end
    if end_at
      unless start_at
        errors[:date_range] << "Nil columns!" 
        return
      end
        
      if start_at > end_at
        errors[:date_range] << "Start date cannot be later than end date."
      end
    end
  end

end
