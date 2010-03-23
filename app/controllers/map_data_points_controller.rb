class MapDataPointsController < ApplicationController

  def new
    @map_data_point = MapDataPoint.new()
  end

  def create
    @map_data_point = MapDataPoint.new(params[:map_data_point])
    
    if @map_data_point.save
    
    else
    
    end
  end
  
end
