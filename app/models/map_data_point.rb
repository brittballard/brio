class MapDataPoint < ActiveRecord::Base
  belongs_to :map
  
  validates_presence_of :lat, :lng, :map_id
end
