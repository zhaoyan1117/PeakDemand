class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :provider, :short_description
  
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  has_many :demands
  has_many :consumers, :through => :demands

  validates :name, :provider, :start_at, :presence => true
  include DateRangeValidation

  before_create :create_calendar

  def provider_name
    provider.name
  end

  def get_number_of_demands
    demands.size
  end

  def get_url
    start = start_at.strftime '%Y%m%d'
    done = end_at.strftime '%Y%m%d'
    params = {
      dates: [start, done].join("/"), 
      showTitle: '0',
      showNav: '0',
      showPrint: '0',
      showTabs: '0',
      showCalendars: '0',
      showTz: '0',
      ctz: 'America/Los_Angeles'
    }
    
    GCal4Ruby::Calendar.to_iframe self.cal_id, params
  end

  private

  def create_calendar
    service = get_gcal_service
    calendar = GCal4Ruby::Calendar.new(service, :title => "#{name}", :public => true)
    calendar.save
    self.cal_id = calendar.id
  end

  def get_gcal_service
    service = GCal4Ruby::Service.new
    service.authenticate
    service
  end

end
