Factory.define :event do |event|
  event.title("This is a test event")
  event.start_date_time(1.day.from_now)
  event.end_date_time(2.days.from_now)
end