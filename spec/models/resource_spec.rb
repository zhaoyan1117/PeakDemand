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

  context "google calendar integration" do
    
    describe "get_calendar_id" do

      it "should return the calendar if for given calendar type" do
        @r.light_cal_id = 'light_cal_id@google'
        @r.get_calendar_id('light').should == 'light_cal_id@google'
      end

    end

    describe "set_calendar_id" do

      it "should set the calendar if for given calendar type" do
        @r.set_calendar_id('light', 'light_cal_id@google')
        @r.light_cal_id.should == 'light_cal_id@google'
      end

    end

    describe "create_calendar" do

      it "should create four calendars with one for each demand type for this resource" do
        number_of_cals = Demand::INTENSITIES.size

        mock_cal = double(GCal4Ruby::Calendar)
        GCal4Ruby::Service.any_instance.should_receive(:authenticate)
        GCal4Ruby::Calendar.should_receive(:new).exactly(number_of_cals).times.and_return(mock_cal)
        mock_cal.should_receive(:id).exactly(number_of_cals).times
        mock_cal.should_receive(:save).exactly(number_of_cals).times
        @r.should_receive(:set_calendar_id).exactly(number_of_cals).times

        @r.send(:create_calendar)
      end
    end
    
  end

end
