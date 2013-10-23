class Resource < ActiveRecord::Base

  attr_accessible :name, :description, :start_at, :end_at, :creator_id
  
  belongs_to :user, :class_name => 'User', :foreign_key => 'creator_id'

  def creator_name
  	User.find(creator_id).name
  end

end
