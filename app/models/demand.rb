class Demand < ActiveRecord::Base

  INTENSITIES = %w(LIGHT MODERATE HEAVY OCCUPY)

  attr_accessible :start_at, :end_at, :intensity, :consumer, :resource, :description
  belongs_to :consumer, :class_name => 'User', :foreign_key => 'consumer_id'
  belongs_to :resource, :class_name => 'Resource', :foreign_key => 'resource_id'

  validates :intensity, :presence => true, :inclusion => {in: INTENSITIES}
  validates :start_at, :end_at, :consumer, :resource, :presence => true
  validate :validate_start_cannot_be_later_than_end
  validate :validate_date_range_should_be_in_resource_date_range

  def consumer_name
  	consumer.name
  end

  private

  def validate_start_cannot_be_later_than_end
    unless start_at && end_at
      errors[:date_range] << "Nil columns!" 
      return
    end
      
    if start_at > end_at
      errors[:date_range] << "Start date cannot be later than end date."
    end
  end

  def validate_date_range_should_be_in_resource_date_range
    unless resource && start_at && end_at
      errors[:resource_date_range] << "Nil columns!" 
      return
    end

    if start_at < resource.start_at || end_at > resource.end_at
      errors[:resource_date_range] << "Validate date range should be in resource date range."
    end
  end


end
