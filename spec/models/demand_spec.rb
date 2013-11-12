require 'spec_helper'

describe Demand do

  before :each do
    @consumer = mock_model(User)
    
    @resource = mock_model(Resource)
    @resource.stub(:start_at).and_return(Date.yesterday)
    @resource.stub(:end_at).and_return(Date.tomorrow.tomorrow)

    @d = Demand.new(
        :short_description => "test demand",
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

  context "google calendar integration" do
    
    before :each do
      @mock_event = double(GCal4Ruby::Event)
      @mock_cal = double(GCal4Ruby::Calendar)
      @mock_service = double(GCal4Ruby::Service)
    end

    describe "modify_event" do
      it "should update the given event with the specification of this demand" do
        GCal4Ruby::Calendar.should_receive(:find).and_return(@mock_cal)
        @mock_event.should_receive(:calendar=).with(@mock_cal)
        @mock_event.should_receive(:all_day=).with(true)
        @mock_event.should_receive(:start_time=).with(@d.start_at.to_s)
        @mock_event.should_receive(:end_time=).with(@d.end_at.to_s)
        @mock_event.should_receive(:title=).with("[#{@d.intensity}] #{@d.short_description}")
        @mock_event.should_receive(:save)

        @d.send(:modify_event, @mock_event, @mock_service)
      end
    end

    describe "create_event" do
      it "should create event with the specification of this demand" do
        GCal4Ruby::Service.should_receive(:new).and_return(@mock_service)
        @mock_service.should_receive(:authenticate)
        GCal4Ruby::Event.should_receive(:new).and_return(@mock_event)

        @d.should_receive(:modify_event)

        @mock_event.should_receive(:id).and_return(123321)
        @d.should_receive(:event_id=).with(123321)

        @d.send(:create_event)
      end
    end

    describe "update_event" do
      it "should update event with the specification of this demand" do
        GCal4Ruby::Service.should_receive(:new).and_return(@mock_service)
        @mock_service.should_receive(:authenticate)
        GCal4Ruby::Event.should_receive(:find).and_return(@mock_event)

        @d.should_receive(:modify_event)

        @d.send(:update_event)
      end
    end

    describe "delete_event" do
      it "should delete the event on calendar if the corresponding demand is deleted" do
        GCal4Ruby::Service.should_receive(:new).and_return(@mock_service)
        @mock_service.should_receive(:authenticate)
        GCal4Ruby::Event.should_receive(:find).and_return(@mock_event)

        @mock_event.should_receive(:delete)
        
        @d.send(:delete_event)
      end
    end

  end

end
