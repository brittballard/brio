class EventFilterService
  def initialize(event_klass)
    @event_klass = event_klass
  end
  
  def filter_events(params, filter_named_scope)
    conditions = EventFilterService.build_conditions_from_params(params)

    if conditions.any?
      events = @event_klass.send(filter_named_scope).all(:conditions => conditions)
    else
      events = @event_klass.send(filter_named_scope)
    end
    
    events
  end
  
  def self.build_conditions_from_params(params)
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