require 'api/v6/ven_serializer'
class VenArraySerializer < ActiveModel::Serializer
  type :vens
  has_many :vens
end
