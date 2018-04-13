    class EventSignalIntervalSerializer < ActiveModel::Serializer
      attributes :payload

      def payload
        if object.payload == 0
          "normal"
        elsif object.payload == 1
          "moderate"
        elsif object.payload == 2
          "high"
        elsif object.payload == 3
          "special"
        else
          object.payload
        end
      end
    end #class
