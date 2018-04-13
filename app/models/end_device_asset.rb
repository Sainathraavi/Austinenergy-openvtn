class EndDeviceAsset < ActiveRecord::Base
# pbf
#  attr_accessible :name

  validates :name, uniqueness: true
end
