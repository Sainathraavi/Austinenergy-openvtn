require 'pp'


module API
  module V6
    module CustomFormatter
      def self.call(message, backtrace, options, env)
        { message: message, backtrace: backtrace }
      end
    end
    class Length < Grape::Validations::Base
      def validate_param!(attr_name, params)
        unless params[attr_name].length <= @option
          fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be at the most #{@option} characters long"
        end
      end
    end
    class Events < Grape::API
      version 'v6'
      rescue_from :all
      error_formatter :custom, CustomFormatter

      content_type :xml, 'application/xml'
      content_type :json, 'application/json'
      default_format :json


      resource :events do
        http_basic do |name, password|
          user = Account.find_by_name(name)
          user && user.authenticate(password) && user.is_admin

        end
        desc "Create OpenADR 2.0b event"
        params do

        requires :ers, type: Hash do
          requires :ramp_type, type: Integer, values: [10, 30],
          allow_blank: false, desc: "ERS ramp type.  Allowed values are 10 or 30"
          requires :group_number, type: Integer, values: Array(1..1000),
          allow_blank: false, desc: "ERS group.  Allowed values are 1-1000"
          requires :group_type, type: String, values: ["D", "T"],
          allow_blank: false, desc: "ERS group type.  Allowed values are D[eploy] or T[test]"
          optional :ws_type, type: String, allow_blank: false, length: 10,
          allow_blank: false, desc: "ERS WS[weather-sensitive] or NON-WS[non-weather-sensitive]"
          requires :business_hour, type: String, allow_blank: false, desc: "Valid ERS time period",
          values: ["TP1", "TP2", "TP3", "TP4", "TP5", "TP6"]

          requires :deploy_mw, type: Float, values: 0.0..+2000.0,
          allow_blank: false, desc: "ERS deploy MW.  Allowed values 0-2000"
          requires :begin_time, type: String, length: 25,
          allow_blank: false, desc: "ERS event start time.  Alowed format 'yyyy-mm-dd hh:mm:ss CST/CDT"
          requires :qse_name, type: String, allow_blank: false, length: 10
          optional :duration, type: Integer, values: Array(1..720), allow_blank: false
          optional :response_required, type: String, values: ["always", "never"], allow_blank: false
        end

      end

      post do
        # create a new event

        begin
          pp params
          event_manager = EventManager.new
          event_descriptor = EventHelper.get_event_descriptor(params)
          event_str = event_manager.create_new_event(params, event_descriptor, :ers)
          puts event_str
          event_str



        rescue EventException => e
          status 500
          pp  :reason => e.reason, :backtrace => e.backtrace
          {:summary => e.reason}
        rescue => e
          status 500
          pp  :reason => e.message, :backtrace => e.backtrace
          {:summary => e.message}
        end

        end # post


        desc "Read all OpenADR 2.0b events"
        params do

        end
        get do
          begin
          #ActiveRecord::Base.logger = Logger.new(STDOUT)

          status_params = params[:event_status]


          events = []
          if !status_params.nil?
            ids = []
            status_params.each {|i|  ids.push(EventStatus.find_by_name(i)) }
            events = Event.where(:event_status_id => ids.uniq.compact)
          else
            events = Event.all
          end

          ActiveModelSerializers::SerializableResource.new(events, { :adapter => :json }).as_json

        rescue => e
          status 500
          pp  :reason => e.message, :backtrace => e.backtrace
          {:summary => e.message}
        end
        end # get

        desc "READ specified OpenADR 2.0b event"
        params do
          requires :id, type: Integer, desc: "Read a specific Event object"
        end
        get ':id' do

          begin
            ActiveModelSerializers::SerializableResource.new(Event.find(params[:id]), { :adapter => :json }).as_json
          rescue => e
            status 500
            pp  :reason => e.message, :backtrace => e.backtrace
            {:summary => e.message}
          end
        end # get

        desc "CANCEL OpenADR 2.0b event"
        params do
          requires :id, type: Integer, desc: "Cancel and publish a specific Event object"
        end
        put ':id'  do
          begin
            # CANCEL an existing event by id
            EventHelper.cancel_event (params)
          rescue => e
            status 500
            pp  :reason => e.message, :backtrace => e.backtrace
            {:summary => e.message}

          end
        end #


        desc "CANCEL OpenADR 2.0b event"
        params do
          requires :id, type: Integer, desc: "Cancel and publish a specific Event object"
        end
        patch ':id'  do
          begin
            # Cancel an existing event by id
            EventHelper.cancel_event (params)

          rescue => e
            status 500
            pp :reason => e.message, :backtrace => e.backtrace
            {:summary => e.message}
          end

        end #



      end # resource :events

    end # class Events


    # custom exception
    class EventException < StandardError
      attr_reader :reason
      def initialize(reason)
        @reason = reason
      end
    end

    class EventManager

      attr_reader :event
      attr_reader :event_actions

      public

      def initialize
        @event_actions = {}
      end

      def create_new_event(params, event_descriptor, event_type)

        e = Event.new(params.permit( :duration, :priority, :test_event,
          :vtn_comment, :response_required_type_id, :dtstart_str,
          :market_context_id ))

        e.duration = params[event_type][ :duration ]
        e.market_context_id = params[event_type][ :market_context_id ]
        e.vtn_comment = params[event_type][ :vtn_comment ]
        e.test_event = "false" #params[event_type][ :test_event ]
        e.dtstart_str = params[event_type][ :dtstart_str ]
        e.priority = params[event_type][ :priority ]
        e.response_required_type_id = params[event_type][ :response_required_type_id ]

        @event = e
        Event.transaction do
          if event_type == :ers
            ers_process_status = process_ers_event(event_descriptor)
            if  ers_process_status != true
              return ers_process_status

            else
              process_event(event_descriptor)
            end
          else
            process_event(event_descriptor)
          end

        end

      end

      def self.create_event_exception(error_str, error_messages, event_descriptor)
        error_descriptor = {}
        error_descriptor[:error] = error_str
        error_descriptor[:error_messages] = error_messages
        error_descriptor[:event_descriptor] = event_descriptor

        error_descriptor
      end

      private

      def process_event(event_descriptor)
        signal_name_id = event_descriptor[:non_params][:signal_name_id]
        signal_type_id = event_descriptor[:non_params][:signal_type_id]
        payload_value = event_descriptor[:non_params][:payload]
        if Event.default_event(@event, signal_name_id, signal_type_id, payload_value)

#          if @event.dtstart != nil && @event.dtstart < DateTime.now
#           @event.event_status = EventStatus.find_by_name("active")
#          end
            # set ei_rampup so that the event status changes from 'far' to 'near' at t-2 min
            @event.ei_rampup = 2
            @event.save
          if !event_descriptor[:non_params][:resource_type_id].nil?
            event_resource = @event.event_resources.new

            event_resource.resource_type_id = event_descriptor[:non_params][:resource_type_id]
            if !event_resource.save
              #puts pp event_resource.errors
              error_descriptor =
              EventManager.create_event_exception("Unable to Create Event", event_resource.errors, event_descriptor)
              raise EventException, error_descriptor
            end
          end

          # publish the event
          @event.publish
          # return a serialized string
          event.update_status
          ActiveModelSerializers::SerializableResource.new(@event, { :adapter => :json }).as_json


        else
         # couldn't save the Event record; return some errors
         error_descriptor =
         EventManager.create_event_exception("Unable to Create Event",
          @event.errors, event_descriptor)

         raise EventException, error_descriptor

        end

      end



  def process_ers_event(event_descriptor)

    #  purpose:  ensure only one ERS event with appropriate market context
    #  will be active at any given time (ers10, ers30) within
    #  a time window given by dtstart and duration
    @event_actions[:MC_DESCRIPTORS] =
      EventHelper.get_market_context_descriptor()
    @event_actions[:EVENT_STATUS_DESCRIPTORS] =
      EventHelper.get_event_status_descriptor()
    @event_actions[:NEW_EVENT] = @event
    date_field = Event.arel_table[:dtstart]

    duration = @event.duration
    dtstart_str = event_descriptor[:ers][:dtstart_str]
    dtstart = Time.now
    if (dtstart_str &&
      (DateTime.parse(dtstart_str) rescue ArgumentError) == ArgumentError)
      # raise an exception

    else
      if not dtstart_str.nil?
        dtstart = DateTime.parse(dtstart_str).utc
        event_descriptor[:ers][:dtstart_str] = dtstart_str
      end

    end

    event_status_id_array = get_event_status_id_array()

    where_ers_10_hash = {:event_status_id => event_status_id_array,
      :market_context_id => @event_actions[:MC_DESCRIPTORS][:MC_ERS_10].id}
    where_ers_30_hash = {:event_status_id => event_status_id_array,
      :market_context_id => @event_actions[:MC_DESCRIPTORS][:MC_ERS_30].id}

    @event_actions[:ERS_10] = Event.where(where_ers_10_hash).
    where(date_field.gteq(dtstart - duration.minutes)).
    where(date_field.lteq(dtstart + duration.minutes))

    @event_actions[:ERS_30] = Event.where(where_ers_30_hash).
    where(date_field.gteq(dtstart - duration.minutes)).
    where(date_field.lteq(dtstart + duration.minutes))

    # populate error_messages in case an exception is raised
    error_messages = []
    @event_actions[:error_messages] = error_messages
    analyze_events(event_descriptor)

  end


private
  def analyze_events(event_descriptor)
    #
    deploy_mw = event_descriptor[:ers][:deploy_mw]
    #pp "deploy_mw = ".concat(deploy_mw.to_s)

    exist_10 = @event_actions[:ERS_10].count
    exist_30 = @event_actions[:ERS_30].count

    mc_10_id = @event_actions[:MC_DESCRIPTORS][:MC_ERS_10].id
    mc_30_id = @event_actions[:MC_DESCRIPTORS][:MC_ERS_30].id

    ramp_type = event_descriptor[:ers][:ramp_type]
    test_event = event_descriptor[:ers][:test_event]
    vtn_comment = event_descriptor[:ers][:vtn_comment]
    resource_type_id = event_descriptor[ :non_params ][:resource_type_id]
    dtstart_str = event_descriptor[:ers][:dtstart_str]
    duration = event_descriptor[:ers][:duration]


    @event_actions[:error_messages].push({:ramp_type => ramp_type})
    @event_actions[:error_messages].push({:deploy_mw => deploy_mw})

    @event_actions[:error_messages].push({:exist_10 => exist_10})
    @event_actions[:error_messages].push({:exist_30 => exist_30})

    pp event_actions

    if deploy_mw > 0 && exist_10 == 0 && exist_30 == 0
      puts "State 8,16"
      # states 8, 16
      return true

    elsif deploy_mw > 0 && exist_10 == 0 && exist_30 > 0 && ramp_type == 30
      # state 10 -> update_30
      puts "State 10 update existing ERS-30"
      update_events(@event_actions[:ERS_30], resource_type_id, dtstart_str,
      duration, vtn_comment)


    elsif deploy_mw > 0 && exist_10 > 0 && exist_30 == 0 && ramp_type == 30
      # state 12 -> existing ERS_10, now adding ERS_30
      puts "State 12 existing ERS_10, now adding ERS_30"
      return true

    elsif deploy_mw > 0 && exist_10 == 0 && exist_30 > 0 && ramp_type == 10
      # state 18 -> existing ERS_30, now adding ERS_10
      puts "State 18 existing ERS_30, now adding ERS_10"
      return true


    elsif deploy_mw > 0 && exist_10 > 0 && ramp_type == 10
      # State 20 update existing ERS-10
      puts "State 20 update existing ERS-10"
      return update_events(@event_actions[:ERS_10],resource_type_id, dtstart_str,
      duration, vtn_comment)


    elsif deploy_mw > 0 && exist_30 > 0 && ramp_type == 30
      # state 30 -> cancel_10
      puts "State 30 update existing ERS-30"
      update_events(@event_actions[:ERS_30],resource_type_id, dtstart_str,
      duration, vtn_comment)



    elsif deploy_mw == 0 && exist_10 == 0 && exist_30 == 0
      # state 40 -> invalid
      puts "State 40"
      @event_actions[:error_messages].push({:state => 40})
      @event_actions[:error_messages].push({:msg => "No action taken"})
      error_descriptor = EventManager.create_event_exception("No events to cancel for this time window.",
        @event_actions[:error_messages], event_descriptor)

      raise EventException, error_descriptor


    elsif deploy_mw == 0 && exist_10 == 0 && exist_30 > 0 && ramp_type == 30
      # state 42 -> cancel_30
      puts "State 42"
      cancel_events(@event_actions[:ERS_30])
      return ActiveModelSerializers::SerializableResource.new(@event_actions[:ERS_30], { :adapter => :json }).as_json


    elsif deploy_mw == 0 && exist_30 == 0 && ramp_type == 30
      # state 44 -> invalid
      puts "State 44"
      @event_actions[:error_messages].push({:state => 44})
      @event_actions[:error_messages].push({:msg => "No action taken"})
      error_descriptor =
      EventManager.create_event_exception("No ERS-30 event to cancel for this time window",
        @event_actions[:error_messages], event_descriptor)
      raise EventException, error_descriptor


    elsif deploy_mw == 0 && exist_30 > 0 && ramp_type == 30
      # state 46 -> cancel existing ERS-30 events
      puts "State 46 cancel existing ERS-30 events"
      cancel_events(@event_actions[:ERS_30])
      return ActiveModelSerializers::SerializableResource.new(@event_actions[:ERS_30], { :adapter => :json }).as_json

    elsif deploy_mw == 0 && exist_10 == 0 && ramp_type == 10
      # state 50 -> invalid
      puts "State 50"
      @event_actions[:error_messages].push({:state => 50})
      @event_actions[:error_messages].push({:msg => "No Action taken"})
      error_descriptor =
      EventManager.create_event_exception("No ERS-10 event to cancel for this time window",
        @event_actions[:error_messages], event_descriptor)

      raise EventException, error_descriptor


    elsif deploy_mw == 0 && exist_10 > 0 && ramp_type == 10
      # state 52 -> cancel_10
      puts "State 52 cancel existing ERS-10 events"
      cancel_events(@event_actions[:ERS_10])
      return ActiveModelSerializers::SerializableResource.new(@event_actions[:ERS_10], { :adapter => :json }).as_json

    else
      puts "State 99"
      @event_actions[:error_messages].push({:state => 99})
      @event_actions[:error_messages].push({:msg => "No action taken"})
      error_descriptor =
      EventManager.create_event_exception("Unknown Event Type",
        @event_actions[:error_messages], event_descriptor)
      raise EventException, error_descriptor
    end

  end

  def check_events_for_changed_resource_type(events, resource_type_id)
    puts "New resource_type_id = " << resource_type_id
    new_group_type = get_group_type_from_resource_type(ResourceType.find(resource_type_id))
    events.each { |event|
        existing_group_type = get_group_type_from_resource_types(event.resource_types)
        if (new_group_type.casecmp(existing_group_type) != 0)
          cancel_events (events)
          return true
        end

    }
    return false

  end

  def get_group_type_from_resource_types(resource_types)
    group_type = 'D'
    resource_types.each {  |resource_type|
      gtype = get_group_type_from_resource_type(resource_type)
      if (gtype.casecmp('T') == 0)
        return gtype
      end

    }
    group_type

  end
  def get_group_type_from_resource_type(resource_type)
    group_type = 'D'
    if (resource_type.name.casecmp('ers10Test') == 0 ||
      resource_type.name.casecmp('ers30Test') == 0)
      group_type = 'T'
      return group_type
    end
    group_type
  end

  def update_events(events, resource_type_id, dtstart_str, duration, vtn_comment  )

    puts "Checking existing events for change of resource_type_id or ERS group_type (T->D, D->T)"
    status = check_events_for_changed_resource_type(events, resource_type_id)
    if status
      return status
    end

    puts "Updating existing events"
    updated = {}
    events.each { |event|
      if !event.nil?
        update_event(event, resource_type_id, dtstart_str, duration, vtn_comment)
        if event.publish
            puts "Publish Updated Event"
            event.update_status
            updated = ActiveModelSerializers::SerializableResource.new(event, { :adapter => :json }).as_json
            pp updated
        end

      end
    }
    updated

  end

  def update_event(event, resource_type_id, dtstart_str, duration, vtn_comment)
    #event_descriptor[:ers][:dtstart_str]
    event.dtstart_str = dtstart_str
    event.duration = duration
    event.vtn_comment = vtn_comment
    # save the event, including dtstart_str and duration
    if !event.save
      error_descriptor =
      EventManager.create_event_exception("Unable to update Event", event.errors, event_descriptor)
      raise EventException, error_descriptor
    end

    if !EventResource.where(:resource_type_id => resource_type_id, :event_id => event.id).exists?
      event_resource = event.event_resources.new
      event_resource.resource_type_id = resource_type_id
      if !event_resource.save
        error_descriptor =
        EventManager.create_event_exception("Unable to update EventResource",
        event_resource.errors, event_descriptor)
        raise EventException, error_descriptor
      end
    end
  end

  def cancel_events (events)

    events.each { |event|
      if !event.nil?
        if event.cancel
          if event.publish
              puts "Cancelling Event"
              event.update_status
              pp ActiveModelSerializers::SerializableResource.new(event, { :adapter => :json }).as_json
          end

        end
      end
    }

  end

  def get_event_status_id_array
    ids = []
    ids.push(@event_actions[:EVENT_STATUS_DESCRIPTORS][:NEAR].id)
    ids.push(@event_actions[:EVENT_STATUS_DESCRIPTORS][:FAR].id)
    ids.push(@event_actions[:EVENT_STATUS_DESCRIPTORS][:ACTIVE].id)
    ids
  end

end


  class EventHelper

    def self.cancel_event(params)
        event = Event.find(params[:id])
        if !event.nil?
          if event.cancel
            if event.publish
                event.update_status
                ActiveModelSerializers::SerializableResource.new(event, { :adapter => :json }).as_json
            end

          end
        end
    end
    def self.get_market_context_descriptor()
      market_context_descriptor = {}
      market_context_descriptor[:MC_ERS_10] =
        MarketContext.find_by_name("ers10")
      market_context_descriptor[:MC_ERS_30] =
        MarketContext.find_by_name("ers30")

      market_context_descriptor
    end

    def self.get_event_status_descriptor()
      event_status_descriptor = {}
      event_status_descriptor[:COMPLETED] =
        EventStatus.find_by_name("completed")
      event_status_descriptor[:CANCELLED] =
        EventStatus.find_by_name("cancelled")
      event_status_descriptor[:ACTIVE] =
        EventStatus.find_by_name("active")
      event_status_descriptor[:NEAR] =
        EventStatus.find_by_name("near")
      event_status_descriptor[:FAR] =
        EventStatus.find_by_name("far")
      event_status_descriptor
    end

    def self.get_event_descriptor(params)
      # this is the first method called for a POST or new Event.
      # params argument contains the content of the POST from the client
      # the returned 'descriptor' is used further by the calling method
       descriptor = {}
       # non_params are needed to successfully create a new event
       # but are not passed in from the API client
       descriptor[ :non_params ] = {}
       descriptor[ :ers ] = params [:ers]

       event = descriptor[ :non_params ]

       params [:ers][ :dtstart_str ]  = EventHelper.get_dtstart ( descriptor[:ers] )
       # get market_context_id based upon the passed in ramp_type
       market_context = EventHelper.get_market_context ( descriptor[:ers] )
       if !market_context.nil?
         params[:ers][ :market_context_id ] = market_context.id
         event[ :payload ] = EventHelper.get_payload(market_context.name)

       else
         params[:ers][ :market_context_id ] = nil
       end

      # set the vtn_comment to the business_hour passed in
      params[:ers][ :vtn_comment ] = EventHelper.get_vtn_comment(descriptor[:ers])
      # set test_event based upon group_type ('T' or 'D')
      params[:ers][ :test_event ] = EventHelper.get_test_event(descriptor[:ers])

      # set duration
      params[:ers][ :duration ] = EventHelper.get_duration(descriptor[:ers])


      resource_type = EventHelper.get_resource_type(market_context,
          params[ :ers ][ :test_event ], params[ :ers ][ :vtn_comment ])

      if !resource_type.nil?
         event[ :resource_type_id ] = resource_type.id
      else
         event[ :resource_type_id ] = nil
      end

       signal_type = EventHelper.get_signal_type("level")
       if !signal_type.nil?
          event[ :signal_type_id ] = signal_type.id
       else
          event[ :signal_type_id ] = nil
       end

       signal_name = EventHelper.get_signal_name("simple")
       if !signal_name.nil?
          event[ :signal_name_id ] = signal_name.id
       else
          event[ :signal_name_id ] = nil
       end

       # set the response_required_type_id
       response_type_param = params[:ers][:response_required]

       if !response_type_param then
         response_type_param = "always"
       end
       response_type = EventHelper.get_response_type(response_type_param)
       if !response_type.nil?
          params[:ers][ :response_required_type_id ] = response_type.id
       else
          params[:ers][ :response_required_type_id ] = nil
       end


      descriptor
    end


    def self.get_response_type (response_type)
        ResponseRequiredType.find_by_name(response_type)
    end

    def self.get_signal_type (signal_type)
      SignalType.find_by_name(signal_type)
    end

    def self.get_signal_name (signal_name)
       SignalName.find_by_name(signal_name)
    end

    def self.get_resource_type ( context, group_type, business_hour )
      resource_type_name = business_hour

      if (group_type.casecmp('T') == 0)
        if (context.name.casecmp('ers10') == 0)
          resource_type_name = 'ers10Test'
        else
          resource_type_name = 'ers30Test'
        end
      end

      resource_type = ResourceType.find_by_name(resource_type_name)
      resource_type
    end
#end

    def self.get_dtstart (params)
      dtstart_str  = params[ :begin_time ]
      params.delete ( :begin_time )
      dtstart_str
    end

    def self.get_market_context( params )
      ramp_type = params[ :ramp_type ]
      #params.delete ( :ramp_type )
      if ramp_type == 10
          market_context = MarketContext.find_by_name("ers10")
      elsif ramp_type == 30
          market_context = MarketContext.find_by_name("ers30")
      else
          market_context = nil
      end
      market_context
    end

    def self.get_payload( market_context )

      if market_context == "ers30"  || market_context == "ers10"
         2
      else
         0
      end

    end
    def self.get_vtn_comment( params )
      business_hour = params [ :business_hour ]
      params.delete ( :business_hour )
      business_hour

    end

    def self.get_test_event( params )

      group_type = params[ :group_type ]
      params.delete( :group_type )
      group_type

    end

    def self.get_duration( params )
      duration = 480
      if !params[:duration].nil?
        duration = params[:duration]
      end
      duration
    end

  end
  end # module V6
end # module API
