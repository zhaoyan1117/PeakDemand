require 'spec_helper'

describe Resource do

  before :each do
    @provider = mock_model(User)

    @r = Resource.new(
      :name => "sample_resource",
      :start_at => Date.today,
      :end_at => Date.tomorrow,
      :provider => @provider,
      :description => "description"
      )
  end

  it "should have a name" do
    @r.name = nil
    @r.valid?.should be_false
    @r.errors.messages.should include(:name)
  end

  it "should have a start date" do
    @r.start_at = nil
    @r.valid?.should be_false
    @r.errors.messages.should include(:start_at)
    @r.errors.messages.should include(:date_range)
  end

  it "should have an end date" do
    @r.end_at = nil
    @r.valid?.should be_false
    @r.errors.messages.should include(:end_at)
    @r.errors.messages.should include(:date_range)
  end

  it "should belong to an provider" do
    @r.provider = nil
    @r.valid?.should be_false
    @r.errors.messages.should include(:provider)
  end

  it "should not have a start date later than its end date" do
    @r.end_at = Date.yesterday.yesterday
    @r.valid?.should be_false
    @r.errors.messages.should include(:date_range)
  end

  describe "provider_name" do

    it "should return the provider name" do
      @provider.should_receive(:name)
      @r.provider_name
    end

  end

  describe "get_number_of_demands" do

    it "should return the number of demands this resource has" do
      @r.demands.should_receive(:size)
      @r.get_number_of_demands
    end

  end

end
