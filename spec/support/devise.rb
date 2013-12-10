module DeviseHelper

  def login_provider
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  def login_consumer
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user, :is_provider => false, :is_consumer => true)
    sign_in @user
  end

  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user, :is_provider => true, :is_consumer => true, :is_administrator => true)
    sign_in @user
  end

  def log_out
    sign_out :user
  end

end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include DeviseHelper, :type => :controller
end
