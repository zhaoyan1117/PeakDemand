require 'spec_helper'

describe Announcement do

	describe 'creator_name' do
		it 'should return the creator name' do
	      	a = FactoryGirl.build :announcement
	      	a.creator_name.should == 'User'
		end
	end

end
