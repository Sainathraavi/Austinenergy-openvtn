require 'api/v6/event_signal_interval_serializer'
class EventSignalSerializer < ActiveModel::Serializer
  has_many :event_signal_intervals#, :embed_key => :intervals
end #class

