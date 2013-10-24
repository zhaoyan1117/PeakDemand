class Demand < ActiveRecord::Base

  INTENSITIES = %w(LIGHT MODERATE HEAVY OCCUPY)

  attr_accessible :start_at, :end_at, :intensity, :consumer, :resource, :description

  belongs_to :consumer, :class_name => 'User', :foreign_key => 'consumer_id'
  belongs_to :resource, :class_name => 'Resource', :foreign_key => 'resource_id'

  validates :intensity, :presence => true,
  				 :inclusion => {in: INTENSITIES}

  validates :start_at, :end_at, :consumer, :resource, :presence => true

  def consumer_name
  	consumer.name
  end

end
