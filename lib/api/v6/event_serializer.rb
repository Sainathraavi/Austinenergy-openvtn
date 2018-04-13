require 'api/v6/resource_type_serializer'
require 'api/v6/event_opt_serializer'
require 'api/v6/ven_serializer'
#require 'api/v6/event_signal_serializer'

class EventSerializer < ActiveModel::Serializer
  type :event
  attributes :summary, :id, :event_id, :group_type, :begin_time, :business_hour,
  :duration, :created_at, :updated_at, :modification_number,
  :published, :event_status, :market_context
  has_many :vens
  has_many :resource_types
  has_many :event_opts

  #has_many :event_signals

  def begin_time
    object.dtstart
  end

  def business_hour
    object.vtn_comment
  end

  def event_status
    if !object.event_status.nil?
      object.event_status.name
    end
  end

  def group_type
    object.test_event
  end

  def market_context
    if !object.market_context.nil?
      object.market_context.name
    end
  end

  def summary
    s = Summary.new(object)
    SummarySerializer.new(s).as_json( { :root => :summary })
  end
end # class
