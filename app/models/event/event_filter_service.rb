class EventFilterService
  def initialize(event_klass)
    @event_klass = event_klass
  end
  
  def search_open(params={})
    filter_events(params, :registration_open)
  end
  
  def search_my(params={})
    @event_klass.all(:joins => :registrants, :conditions => build_conditions_from_params(params))
  end
  
  def search_results(params={})
    filter_events(params, :complete)
  end
  
  private
  
  def filter_events(params, filter_named_scope)
    conditions = build_conditions_from_params(params)

    if conditions.any?
      events = @event_klass.send(filter_named_scope).all(:conditions => conditions)
    else
      events = @event_klass.send(filter_named_scope)
    end
    
    events
  end
  
  def build_conditions_from_params(params)
    conditions = []
    conditions_params = {}
    
    if params[:name].present?
      conditions << "title like :name"
      conditions_params.merge!({ :name => params[:name]})
    end
    
    if params[:date].present?
      conditions << ":date between start_date_time and end_date_time"
      conditions_params.merge!({ :date => params[:date]})
    end
    
    if params[:location].present?
      # what are we doing with locations
    end
    
    [conditions.any? ? conditions.join(' and ') : nil, conditions_params.any? ? conditions_params : nil].compact
  end
  
end