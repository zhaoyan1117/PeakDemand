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
    r = Resource.new params["resource"].merge("provider" => @user)

    if r.save
      redirect_to resource_index_url
    else
      flash[:error] = r.errors.full_messages
      redirect_to new_resource_url
    end
  end

  def show
    @calendar_xml_feed = @resource.get_xml_feed
  end

  def edit
  end

  def update
    if @resource.update_attributes params["resource"].merge("provider" => @user)
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

end
