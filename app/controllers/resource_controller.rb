class ResourceController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :get_resource, :except => [:index, :new, :create]
  before_filter :get_current_user
  
  def index
    @resources = Resource.all
  end

  def new
  end

  def create
    
    resource_param = get_resource_param

    r = Resource.new resource_param
    
    if r.save
      redirect_to resource_index_url
    else
      redirect_to new_resource_url
    end

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

  def get_current_user
    @user = current_user
  end

  def get_resource
    @resource = Resource.find(params[:id])
  end

  def get_resource_param
    params["resource"].clone.tap do |r|
      r["start_at"] = Date.new( r["start_at(1i)"].to_i, 
                                r["start_at(2i)"].to_i, 
                                r["start_at(3i)"].to_i )

      r["end_at"] = Date.new( r["end_at(1i)"].to_i, 
                              r["end_at(2i)"].to_i, 
                              r["end_at(3i)"].to_i )
      
      r["provider"] = @user

      r.delete "start_at(1i)"; r.delete "start_at(2i)"; r.delete "start_at(3i)"
      r.delete "end_at(1i)"; r.delete "end_at(2i)"; r.delete "end_at(3i)"
    end
  end

end
