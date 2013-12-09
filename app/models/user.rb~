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
  validates :email, :uniqueness => true

  def is_provider?
    is_provider
  end

  def is_admin?
    is_administrator
  end

  def validate_must_have_identity
    if !is_provider && !is_consumer
      errors[:identity] << "must have an identity!"
    end
  end

end
