class BillingInformation < ApplicationRecord
  has_many :carts
  belongs_to :account

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :postal
  validates_presence_of :city
  validates_presence_of :state

  attr_accessor :current_account
  attr_accessor :current_cart

  before_validation :associate_current_cart
  before_validation :associate_current_account

  private def associate_current_cart
    self.carts << current_cart.assign_attributes(billing_information: self)
  end

  private def associate_current_account
    assign_attributes(account: current_account)
  end
end
