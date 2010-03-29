class EventCreationService
  def initalize(event_klass)
    @user_klass = event_klass
  end
  
  def create(params)
    @user_klas.create(params)
  end
end