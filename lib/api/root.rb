module API
  class Root < Grape::API
    prefix 'api'
    mount API::V6::Root #(next version)
  end
end
