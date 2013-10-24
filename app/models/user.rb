class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me 
  attr_accessible :name, :is_provider, :is_consumer, :is_administrator

  has_many :resources
  validate :validate_must_have_identity
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


end
