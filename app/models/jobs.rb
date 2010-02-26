class Jobs < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :start_date_time
  validates_presence_of :end_date_time
end
