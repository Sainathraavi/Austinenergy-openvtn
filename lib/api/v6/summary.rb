class Summary
  include ActiveModel::Serialization
  alias :read_attribute_for_serialization :send
  attr_reader :status, :ramp_type, :group_type, :begin_time, :business_hour, :vens

public
  def initialize(event)
    @vens = Array.new
    print_group_type event
    print_ramp_type event
    print_status event
    print_begin_time event

  end

private
  def print_group_type(event)
    first = true
    # loop through event ResourceType
    @group_type = 'D'
    event.resource_types.each do |resource_type|

        if (resource_type.name.casecmp('ers10Test') == 0 ||
          resource_type.name.casecmp('ers30Test') == 0)
          @group_type='T'
          @business_hour='TEST'
        else
          if (!first)
            @business_hour = @business_hour + ", " + resource_type.name
          else
            @business_hour = resource_type.name
            first = false
          end
        end
    end
  end

  def print_ramp_type(event)
    #.market_context.name
    if !event.market_context.nil?
      if (event.market_context.name.casecmp('ers10') == 0)
        @ramp_type = '10'
      elsif (event.market_context.name.casecmp('ers30') == 0)
        @ramp_type = '30'
      else
        @ramp_type = 'Unknown'
      end
    end
  end

  def print_status(event)
    current_health = 0
    @status = 'Event is '
    status_name = EventStatus.find(event.event_status).name

    if (status_name.casecmp('near') == 0 ||
      status_name.casecmp('far') == 0 )
      @status << 'Not Yet Active'
    else
      @status << status_name

    end

    event.vens.each do |ven|
      ven_health = VenHealth.new (ven)

      if (ven_health.health_status > current_health)
        current_health = ven_health.health_status
      end
      @vens.push ven_health.summary
    end
    @vens.sort
    if (current_health > 0)
      @status << ' and has VEN health issues'
    end



  end

  def print_begin_time(event)
    if (!event.dtstart.nil?)
      @begin_time=event.dtstart.to_s(:iso8601)
    end
  end

end
