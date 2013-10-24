class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me 
  attr_accessible :name, :is_provider, :is_consumer, :is_administrator

  has_many :resources, :class_name => 'Resource', :foreign_key => 'provider_id'
  has_many :demands, :class_name => 'Demand', :foreign_key => 'consumer_id'

  validate :validate_must_have_identity
  validate :validate_only_provider_can_create_resources
  validate :validate_only_consumer_can_create_demands
  validates :email, :uniqueness => true

  def identity
  	identity = []

		identity << "Provider" if is_provider
	  identity << "Consumer" if is_consumer

    identity.join(", ")
  end

  def validate_must_have_identity
    if !is_provider && !is_consumer
      errors[:base] << "must have an identity!"
    end
  end

  def validate_only_provider_can_create_resources
    if !is_provider && !resources.empty?
      errors[:base] << "only provider can create resources!"
    end
  end

  def validate_only_consumer_can_create_demands
    if !is_consumer && !demands.empty?
      errors[:base] << "only consumers can create demands!"
    end

  end


end
