class EventCreationService
  def initalize(event_klass)
    @event_klass = event_klass
  end
  
  def create(params)
    @event_klass.create(params)
  end
end