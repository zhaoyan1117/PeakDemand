class DemandController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]
  before_filter :get_demand, :except => [:new, :create]
  before_filter :get_resource
  before_filter :get_current_user

  def new
    unless @user.is_consumer
      flash[:error] = ["Please register as a consumer to create demand!"]     
      redirect_to resource_url(@resource)
    end

    get_intensities
  end

  def create
    d = Demand.new params["demand"].merge("consumer" => @user, "resource" => @resource)
    
    if !d.save
      flash[:error] = d.errors.full_messages
    end
    
    redirect_to resource_url(@resource)
  end

  def show
    render :json => @demand, :include => :consumer
  end

  def edit
    get_intensities
  end

  def update
    if @demand.update_attributes params["demand"].merge("consumer" => @user, "resource" => @resource)
      redirect_to resource_demand_url(@resource, @demand)
    else
      redirect_to edit_resource_demand_url(@resource, @demand)
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

  def get_intensities
    @intensities = Demand::INTENSITIES
  end

end
