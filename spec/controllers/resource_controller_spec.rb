require 'spec_helper'

describe ResourceController do

  describe "index" do
    it "should call Resource's all method to retrieve all resources"
  end

  describe "new" do
    it "should render new page if user is a provider"

    it "should redirect_to to resource index page with an error message if user is not a provider"
  end

  describe "create" do
    it "should redirect to resource index page if save successfully"

    it "should redirect to new resource page if save failed"
  end

  describe "update" do
    it "should redirect to resource page if save successfully"

    it "should redirect to new resource page if save failed"
  end

  describe "destroy" do
    it "should call the destroy method of a given resource"

    it "should redirect to resource index page"
  end

end
