class SummarySerializer < ActiveModel::Serializer
  attributes :status, :ramp_type, :group_type, :begin_time, :business_hour
  attribute :vens, key: :ven_healths
end
