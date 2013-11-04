class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :provider, :short_description
  
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  has_many :demands
  has_many :consumers, :through => :demands

  validates :name, :provider, :start_at, :end_at, :presence => true
  include DateRangeValidation

  def provider_name
    provider.name
  end

  def get_number_of_demands
    demands.size
  end

end

