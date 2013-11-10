class Demand < ActiveRecord::Base

  INTENSITIES = %w(LIGHT MODERATE HEAVY OCCUPY)

  attr_accessible :start_at, :end_at, :intensity, :consumer, :resource, :description, :short_description
  belongs_to :consumer, :class_name => 'User', :foreign_key => 'consumer_id'
  belongs_to :resource, :class_name => 'Resource', :foreign_key => 'resource_id'

  validates :intensity, :presence => true, :inclusion => {in: INTENSITIES}
  validates :start_at, :end_at, :consumer, :resource, :presence => true
  validate :validate_date_range_should_be_in_resource_date_range
  include DateRangeValidation

  after_commit :update_event
  after_create :create_event
  after_destroy :delete_event
  
  def consumer_name
  	consumer.name
  end

  private

  def validate_date_range_should_be_in_resource_date_range
    unless resource && start_at && end_at
      errors[:resource_date_range] << "Nil columns!" 
      return
    end

    if start_at < resource.start_at || end_at > resource.end_at
      errors[:resource_date_range] << "Validate date range should be in resource date range."
    end
  end

  def create_event
    service = get_gcal_service
    cal_id = resource.get_calendar_id(intensity)

    cal = GCal4Ruby::Calendar.find(service, {:id => cal_id})

    event = GCal4Ruby::Event.new(service)
    event.calendar = cal
    event.all_day = true
    event.start_time = start_at.to_s
    event.end_time = end_at.to_s
    event.title = short_description
    event.save
    
    self.event_id = event.id and save!
  end

  def update_event
    service = get_gcal_service
    cal_id = resource.get_calendar_id(intensity)

    cal = GCal4Ruby::Calendar.find(service, {:id => cal_id})

    event = GCal4Ruby::Event.find(service, {:id => event_id})
    event.calendar = cal
    event.all_day = true
    event.start_time = start_at.to_s
    event.end_time = end_at.to_s
    event.title = short_description
    event.save
  end

  def delete_event
    service = get_gcal_service
    event = GCal4Ruby::Event.find(service, {:id => event_id})
    event.delete
  end

  def get_gcal_service
    service = GCal4Ruby::Service.new
    service.authenticate
    service
  end

end
