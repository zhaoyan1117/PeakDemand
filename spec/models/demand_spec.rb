require 'spec_helper'

describe Demand do

  before :each do
    @consumer = mock_model(User)
    
    @resource = mock_model(Resource)
    @resource.stub(:start_at).and_return(Date.yesterday)
    @resource.stub(:end_at).and_return(Date.tomorrow.tomorrow)

    @d = Demand.new(
        :start_at => Date.today,
        :end_at => Date.tomorrow,
        :intensity => "LIGHT",
        :consumer => @consumer,
        :resource => @resource,
        :description => "This is a test demand"
      )
  end

  it "should have a start date" do
    @d[:start_at] = nil
    @d.valid?.should be_false
    @d.errors.messages.should include(:start_at)
    @d.errors.messages.should include(:date_range)
    @d.errors.messages.should include(:resource_date_range)
  end

  it "should have an end date" do
    @d[:end_at] = nil
    @d.valid?.should be_false
    @d.errors.messages.should include(:end_at)
    @d.errors.messages.should include(:date_range)
    @d.errors.messages.should include(:resource_date_range)
  end

  it "start date should not be later than end date" do
    @d[:end_at] = Date.yesterday.yesterday
    @d.valid?.should be_false
    @d.errors.messages.should include(:date_range)
  end


  it "should have intensity specified within INTENSITIES variables" do
    @d[:intensity] = "WHATEVER"
    @d.valid?.should be_false
    @d.errors.messages.should include(:intensity)
  end

  it "should belong to a resource" do
    @d.resource = nil
    @d.valid?.should be_false
    @d.errors.messages.should include(:resource)
    @d.errors.messages.should include(:resource_date_range)
  end

  it "should belong to a consumer" do
    @d.consumer = nil
    @d.valid?.should be_false
    @d.errors.messages.should include(:consumer)
  end

  it "should have date range within the date range of the resource" do
    @resource.should_receive(:start_at)
    @resource.should_receive(:end_at).and_return(Date.yesterday)
    @d.valid?.should be_false
    @d.errors.messages.should include(:resource_date_range)
  end

  describe "consumer_name" do
    it "should return the consumer's name of the demand" do
      @consumer.should_receive(:name).and_return("name")
      @d.consumer_name.should == "name"
    end
  end

end
