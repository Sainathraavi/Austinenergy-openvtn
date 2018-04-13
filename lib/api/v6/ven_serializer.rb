require 'api/v6/resource_serializer'
class VenSerializer < ActiveModel::Serializer
	type :ven
	attributes :id, :name, :last_poll_time, :status, :polling_health
	has_many :resources

  def polling_health

		ven_health = VenHealth.new (object)
		ven_health.status


  end
  def last_poll_time
    object.last_comm_at
  end
end #class
