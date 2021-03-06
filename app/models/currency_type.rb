# == Schema Information
#
# Table name: currency_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CurrencyType < ActiveRecord::Base
#  attr_accessible :description, :name

  validates_uniqueness_of :name

  def custom_description
    self.name + " (#{self.description})"
  end
end
