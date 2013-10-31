class ResourceController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :get_resource, :except => [:index, :new, :create]
  before_filter :get_current_user
  
  def index
    @resources = Resource.all
  end

  def new
    unless @user.is_provider
      flash[:error] = ["Please register as a provider to create resource!"]      
      redirect_to resource_index_url
    end
  end

  def create
    
    resource_param = get_resource_param

    r = Resource.new resource_param
    
    if r.save
      redirect_to resource_index_url
    else
      flash[:error] = r.errors.full_messages
      redirect_to new_resource_url
    end

  rescue ArgumentError
    flash[:error] = {:date => "Invalid Date."}
    redirect_to new_resource_url
  end

  def show
  end

  def edit
  end

  def update
    resource_param = get_resource_param
    
    @resource.update_attributes resource_param
    
    if @resource.save
      redirect_to resource_url(@resource)
    else
      redirect_to edit_resource_url(@resource)
    end

  end

  def destroy
    @resource.destroy
    redirect_to resource_index_url
  end

  private

  def get_resource
    @resource = Resource.find(params[:id])
  end

  def get_resource_param
    params["resource"].clone.tap do |r|
      r["start_at"] ||= create_date r, "start_at"
      r["end_at"] ||= create_date r, "end_at"

      r["provider"] = @user
    end
  end

end
