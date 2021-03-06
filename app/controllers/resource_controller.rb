class ResourceController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :get_resource, :except => [:index, :new, :create]
  before_filter :get_current_user
  
  def index
    @resources = Resource.all
    @announcements = Announcement.all
  end

  def create
    r = Resource.new params["resource"].merge("provider" => @user)

    if r.save
      render :json => r.attributes.merge({:url => resource_url(r), :provider_name => r.provider_name})
    else
      render :json => {:errors => r.errors.full_messages}
    end
  end

  def show
    @calendar_xml_feed = @resource.get_xml_feed
    @cgi_cal_id = @resource.get_cgi_calendar_id
    @intensities = Demand::INTENSITIES
  end

  def update
    if @resource.update_attributes params["resource"].merge("provider" => @user)
      render :json => @resource.attributes
    else
      render :json => {:errors => @resource.errors.full_messages}
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
