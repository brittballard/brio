class Event < ActiveRecord::Base
  has_many :registrants, :class_name => 'User', :foreign_key => 'user_id'
  has_many :volunteers, :class_name => 'User', :foreign_key => 'user_id'
  validates_presence_of :title
end
