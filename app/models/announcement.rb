class Announcement < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'

  attr_accessible :body, :created_at, :title

  validates :title, :body, :created_at, :creator_id, :presence => true



end
