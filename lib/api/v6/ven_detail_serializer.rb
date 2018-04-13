require 'api/v6/ven_serializer'
class VenDetailSerializer < VenSerializer
  type :ven
  attributes :created_at, :updated_at, :email, :phone

  def phone
     object.address
  end


end #class
