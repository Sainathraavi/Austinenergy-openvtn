require 'pp'
require 'api/v6/ven_serializer'
require 'api/v6/ven_detail_serializer'

module API
  module V6
    class Vens < Grape::API
      version 'v6'
      rescue_from :all
      content_type :xml, 'application/xml'
      content_type :json, 'application/json'
      default_format :json
      resource :vens do
        desc "Read all OpenADR 2.0b VENs"
        params do
          # do something with parameters
        end
        http_basic do |name, password|
          user = Account.find_by_name(name)
          user && user.authenticate(password) && user.is_admin

        end
        get do
          begin
             ActiveModelSerializers::SerializableResource.new(Ven.all, { :adapter => :json }).as_json
          rescue => e
            status 500
            pp  :reason => e.message, :backtrace => e.backtrace
            {:summary => e.message}
          end
        end # get


        desc "Read specified OpenADR 2.0b VEN"
        params do
          # do something with parameters
        end
        get ':id' do
          begin
            ActiveModelSerializers::SerializableResource.new(Ven.find(params[:id]), { :adapter => :json }).as_json
          rescue => e
            status 500
            pp :reason => e.message, :backtrace => e.backtrace
            {:summary => e.message}
          end
        end # get

      end # resource
    end # class
  end # module
end # module
