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

    demand_param = get_demand_param

    d = Demand.new(demand_param)
    
    if d.save
      redirect_to resource_demand_url(@resource, d)
    else
      flash[:error] = d.errors.full_messages
      redirect_to new_resource_demand_url(@resource)
    end

  end

  def show
  end

  def edit
    get_intensities
  end

  def update
    demand_param = get_demand_param
    
    @demand.update_attributes demand_param
    
    if @demand.save
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

  def get_demand_param
    params["demand"].clone.tap do |d|
      d["start_at"] ||= create_date d, "start_at"
      d["end_at"] ||= create_date d, "end_at"

      d["consumer"] = @user
      d["resource"] = @resource
    end
  end

  def get_intensities
    @intensities = Demand::INTENSITIES
  end

end
