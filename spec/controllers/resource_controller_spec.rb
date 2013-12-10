require 'spec_helper'

describe ResourceController do
  
  describe "GET /index" do
    it "should call Resource's all method to retrieve all resources" do
      Resource.should_receive :all

      get :index
      response.should render_template "resource/index"
      response.status.should == 200
    end
  end

  describe "POST /create" do
    before :each do
      login_provider
      @resource_param = FactoryGirl.attributes_for :resource
    end

    it "should redirect to resource index page if save successfully" do
      # Should create calendars after successful creation.
      Resource.any_instance.should_receive(:create_calendar)
      post :create, :resource => @resource_param
    end

    it "should redirect to new resource page if save failed" do
      controller.should_receive(:get_current_user).and_return(nil)

      post :create, :resource => @resource_param
    end
  end

  describe "PUT /update" do
    before :each do
      login_provider
      @resource_param = FactoryGirl.attributes_for :resource, :name => "new_name"
      @r = FactoryGirl.build :resource, :provider => @user
    end

    it "should redirect to resource page if save successfully" do
      Resource.should_receive(:find).and_return(@r)
      @r.should_receive(:update_attributes).and_return(true)

      put :update, :id => @r.id, :resource => @resource_param
    end

    it "should redirect to new resource page if save failed" do
      Resource.should_receive(:find).and_return(@r)
      controller.should_receive(:get_current_user).and_return(nil)

      put :update, :id => @r.id, :resource => @resource_param
    end
  end

  describe "DELETE /destroy" do
    it "should call the destroy method of a given resource and redirect_to resource_index_url" do
      login_provider
      r = FactoryGirl.build :resource, :provider => @user

      Resource.should_receive(:find).and_return(r)
      r.should_receive(:destroy)

      delete :destroy, :id => r.id
      response.should redirect_to resource_index_url
      response.status.should == 302
    end
  end
end
