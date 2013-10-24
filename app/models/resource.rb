class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :provider
  
  belongs_to :provider, :class_name => 'User', :foreign_key => 'provider_id'
  has_many :demands
  has_many :consumers, :through => :demands

  validates :name, :provider, :presence => true
  validate :validate_start_cannot_be_later_than_end

  def provider_name
  	provider.name
  end

  def get_number_of_demands
  	demands.size
  end

  private

  def validate_start_cannot_be_later_than_end
  	if start_at > end_at
  		errors[:base] << "Start date cannot be later than end date."
  	end
  end

end

