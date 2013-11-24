require 'spec_helper'

describe DemandController do

  before :each do
    @resource = FactoryGirl.build :resource
  end

  describe "GET /new" do
    it "should redirect to login page if there is no user login" do
      log_out

      get :new, :resource_id => @resource.id
      response.status.should == 302
    end

    it "should render new page if user is a consumer" do
      login_consumer
      User.any_instance.should_receive(:is_consumer).and_call_original
      Resource.should_receive(:find).and_return(@resource)

      get :new, :resource_id => @resource.id
      response.should render_template "demand/new"
      response.status.should == 200
    end

    it "should redirect_to to resource page with an error message if user is not a consumer" do
      login_provider
      User.any_instance.should_receive(:is_consumer).and_call_original
      Resource.should_receive(:find).and_return(@resource)

      get :new, :resource_id => @resource.id
      response.should redirect_to resource_url(@resource)
      response.status.should == 302
    end
  end

  describe "POST /create" do
    before :each do
      login_consumer
      @demand_param = FactoryGirl.attributes_for :demand, :consumer => @user, :resource => @resource
      @demand = FactoryGirl.build :demand, :consumer => @user, :resource => @resource
    end

    it "should redirect to resource page if save successfully" do
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:new).and_return(@demand)
      @demand.should_receive(:create_event)
      @resource.stub(:create_calendar)

      post :create, :resource_id => @resource.id, :demand => @demand_param
      response.should redirect_to resource_url(@resource)
      response.status.should == 302
    end

    it "should redirect to resource page witha error messages if save failed" do
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:new).and_return(@demand)
      @demand.stub(:save).and_return(false)

      post :create, :resource_id => @resource.id, :demand => @demand_param
      flash[:error].should_not be_nil
      response.should redirect_to resource_url(@resource)
      response.status.should == 302
    end
  end

  describe "GET /edit" do
    it "should call get_intensities to get demand's intensity options" do
      login_consumer
      d = FactoryGirl.build :demand, :consumer => @user, :resource => @resource
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:find).and_return(d)

      controller.should_receive(:get_intensities)

      get :edit, :resource_id => @resource.id, :id => d.id
      response.should render_template "demand/edit" 
    end
  end

  describe "PUT /update" do
    before :each do
      login_consumer
      @demand_param = FactoryGirl.attributes_for :demand, :consumer => @user, :resource => @resource, :intensity => "MODERATE"
      @demand = FactoryGirl.build :demand, :consumer => @user, :resource => @resource
    end
    
    it "should redirect to resource demand page if save successfully" do
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:find).and_return(@demand)
      @demand.should_receive(:update_event)
      
      @demand.stub(:create_event)      
      @resource.stub(:create_calendar)

      @demand.save
      put :update, :resource_id => @resource.id, :demand => @demand_param, :id => @demand.id

      response.should redirect_to resource_demand_url(@resource, @demand)
      response.status.should == 302
    end

    it "should redirect to edit resource demand page if save failed" do
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:find).and_return(@demand)
      @demand.stub(:save).and_return(false)

      put :update, :resource_id => @resource.id, :demand => @demand_param, :id => @demand.id
      response.should redirect_to edit_resource_demand_url(@resource, @demand)
      response.status.should == 302
    end

  end

  describe "DELETE /destroy" do
    it "should call the destroy method of a given resource and redirect to resource page" do
      login_consumer
      d = FactoryGirl.build :demand, :consumer => @user, :resource => @resource

      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:find).and_return(d)
      d.should_receive(:destroy).and_call_original
      d.should_receive(:delete_event)

      delete :destroy, :resource_id => @resource.id, :id =>d.id
      response.should redirect_to resource_url(@resource)
      response.status.should == 302
    end
  end

end
