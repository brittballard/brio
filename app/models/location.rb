class Location < ActiveRecord::Base
  validates_presence_of :map_url
  validates_presence_of :title
  validates_presence_of :description
end
