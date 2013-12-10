class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :provider, :short_description
  
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  has_many :demands
  has_many :consumers, :through => :demands

  validates :name, :provider, :start_at, :presence => true
  include DateRangeValidation

  before_create :create_calendar

  def provider_name
    names = provider.name.split(' ')
    if names[1]
      result = names[0][0,8]
      result += ' ' + names[1][0,1]
    else
      result = names[0][0,10]
    end
    result
  end

  def is_my_resource? user
    provider == user || demands.any? { |d| d.consumer == user }
  end

  def get_number_of_demands
    demands.size
  end

  def get_xml_feed
    GCal4Ruby::Calendar.get_xml_feed(cal_id)
  end

  def get_cgi_calendar_id
    CGI.unescape(cal_id) if cal_id
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
