class Event < ActiveRecord::Base
  has_and_belongs_to_many :registrants, :class_name => 'User'
  has_and_belongs_to_many :volunteers, :class_name => 'User'
  validates_presence_of :title
end
