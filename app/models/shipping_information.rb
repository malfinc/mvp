class ShippingInformation < ApplicationRecord
  has_many :carts

  validate_presence_of :name
  validate_presence_of :address
  validate_presence_of :postal
  validate_presence_of :city
  validate_presence_of :state
end
