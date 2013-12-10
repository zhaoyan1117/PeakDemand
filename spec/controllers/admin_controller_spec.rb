require 'spec_helper'

describe AdminController do

  describe "GET /index" do
    it "should go to the admin dashboard if user is admin" do
      login_admin

      get 'index'
      response.should render_template "admin/index"
      response.status.should == 200
    end
  end

  describe "GET /enable_user" do
    it "should call User's method to approve user" do
      login_admin

      u = mock_model(User)
      User.should_receive(:approve).with('1').and_return(u)
      u.should_receive(:save)
      
      get 'enable_user', :user_id => '1'
      response.status.should == 302
    end
  end


end
