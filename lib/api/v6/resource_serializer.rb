    class ResourceSerializer < ActiveModel::Serializer
      attributes :erid, :resource_type

      def resource_type
        ResourceType.find(object.resource_type_id).name
      end
      def erid
      	object.name
      end
    end #class
