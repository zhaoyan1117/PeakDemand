require 'spec_helper'

describe AdminController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'enable_user'" do
    it "returns http success" do
      get 'enable_user'
      response.should be_success
    end
  end

  describe "GET 'disable_user'" do
    it "returns http success" do
      get 'disable_user'
      response.should be_success
    end
  end

end
