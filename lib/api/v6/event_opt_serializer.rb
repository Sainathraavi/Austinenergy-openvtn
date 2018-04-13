class EventOptSerializer < ActiveModel::Serializer
  attributes :ven_id, :created_at, :ven_name #, :event_modification_number, :updated_at, 
  attributes :opt_type

  def opt_type
    OptType.find(object.opt_type_id).name
  end
  
  def ven_name
    if !object.ven.nil?
      object.ven.name
    end    
  end
  def ven_id 
    if !object.ven.nil?
      object.ven.id
    end        
  end

end #class
