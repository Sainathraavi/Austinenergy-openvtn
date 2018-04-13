require 'api/v6/events'
require 'api/v6/vens'

module API
  module V6
    class Root < Grape::API
      mount API::V6::Events
      mount API::V6::Vens
    end
  end
end
