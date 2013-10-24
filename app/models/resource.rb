class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :provider
  
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  has_many :demands
  has_many :consumers, :through => :demands

  validates :name, :provider, :presence => true

  def provider_name
  	provider.name
  end

end
