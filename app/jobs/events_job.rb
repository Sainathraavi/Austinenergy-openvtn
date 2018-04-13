require 'app/lib/oadr_logger'

require 'app/models/schedule'
require 'app/models/event'

class EventsJob
  include SuckerPunch::Job

  def perform
    begin
      OadrLogger.instance.log_info('updating schedule and event statuses')
      EventsJob.perform_in(20)
      Schedule.create_events
      Event.update_statuses
    rescue Exception => ex
      OadrLogger.instance.log_caught_exception(ex)
    end

  end
end
