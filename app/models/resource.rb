class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :provider, :short_description
  
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  has_many :demands
  has_many :consumers, :through => :demands

  validates :name, :provider, :start_at, :presence => true
  include DateRangeValidation

  after_create :create_calendar

  def provider_name
    provider.name
  end

  def get_number_of_demands
    demands.size
  end

  def get_url
    cals = [occupy_cal_id, heavy_cal_id, moderate_cal_id, light_cal_id]

    colors = {
      occupy_cal_id => '#A32929',
      heavy_cal_id => '#7A367A',
      moderate_cal_id => '#AB8B00',
      light_cal_id => '#528800'
    }

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
    
    GCal4Ruby::Service.new.to_iframe cals, params, colors
  end

  def get_calendar_id type
    send("#{type.downcase}_cal_id".to_sym)
  end

  def set_calendar_id type, value
    send("#{type.downcase}_cal_id=".to_sym, value)
  end

  private

  def create_calendar
    service = get_gcal_service

    Demand::INTENSITIES.each do |i|
      calendar = GCal4Ruby::Calendar.new(service, :title => "#{name}_#{i}", :public => true)
      calendar.save
      set_calendar_id(i, calendar.id) and save!
    end
  end

  def get_gcal_service
    service = GCal4Ruby::Service.new
    service.authenticate
    service
  end

end
