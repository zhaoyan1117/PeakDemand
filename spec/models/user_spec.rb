require 'spec_helper'

describe User do

  before :each do
    @u1 = User.create!(:name => "u1", 
                       :email => "test@test.com", 
                       :password => "u1password",
                       :password => "u1password",
                       :is_provider => true
                      )
  end

  it "should have an unique email address" do
    u2 = User.new(:name => "u2", 
                  :email => "test@test.com", 
                  :password => "u2password",
                  :password => "u2password",
                  :is_provider => true
                 )

    u2.valid?.should be_false
    u2.errors.messages.should include(:email)
  end

  it "should have an identity" do
    @u1.is_provider = nil
    @u1.is_consumer = nil
    @u1.valid?.should be_false
    @u1.errors.messages.should include(:identity)
  end

  describe "identity" do
    it "should return the identity of the user" do
      @u1.is_consumer = true
      @u1.is_provider = true
      @u1.identity.should include("Provider")
      @u1.identity.should include("Consumer")
    end
  end

  after :each do
    @u1.destroy rescue true
  end

end
