require 'spec_helper'

describe DemandController do

  before :each do
    @resource = FactoryGirl.build :resource
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
    end

    it "should redirect to resource page witha error messages if save failed" do
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:new).and_return(@demand)
      @demand.stub(:save).and_return(false)

      post :create, :resource_id => @resource.id, :demand => @demand_param
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
    end

    it "should redirect to edit resource demand page if save failed" do
      Resource.should_receive(:find).and_return(@resource)
      Demand.should_receive(:find).and_return(@demand)
      @demand.stub(:save).and_return(false)

      put :update, :resource_id => @resource.id, :demand => @demand_param, :id => @demand.id
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
