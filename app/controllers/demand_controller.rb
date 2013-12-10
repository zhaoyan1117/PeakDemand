class DemandController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :get_demand_from_gcal_id]
  before_filter :get_demand, :except => [:new, :create, :get_demand_from_gcal_id]
  before_filter :get_resource
  before_filter :get_current_user

  def create
    d = Demand.new params["demand"].merge("consumer" => @user, "resource" => @resource)
    
    if d.save
      render :json => d
    else
      render :json => {:error => d.errors.full_messages}
    end
  end

  def show
    render :json => @demand, :include => [:consumer, :resource]
  end

  def get_demand_from_gcal_id
    d = Demand.find_from_event_id(@resource, params[:id])
    render :json => d, :include => :consumer
  end
  
  def update
    if @demand.update_attributes params["demand"].merge("consumer" => @user, "resource" => @resource)
      render :json => @demand
    else
      render :json => {:error => @demand.errors.full_messages}
    end
  end

  def destroy
    @demand.destroy
    redirect_to resource_url(@resource)
  end

  private

  def get_demand
    @demand = Demand.find(params[:id])
  end

  def get_resource
    @resource = Resource.find(params[:resource_id])
  end

end
