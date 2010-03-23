class Map < ActiveRecord::Base
  belongs_to :event
  has_many :map_data_points, :dependent => :destroy
  
  validates_presence_of :name, :event_id
end
