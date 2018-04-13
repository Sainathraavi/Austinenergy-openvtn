require 'api/v6/event_serializer'
class EventArraySerializer < ActiveModel::Serializer
  type :events
  has_many :events
end
