class MapsController < ApplicationController
  
  def new
    @map = Map.new()
  end
  
  def create
    @map = Map.new(params[:map])
    
    if @map.save

    else

    end
  end
  
end
