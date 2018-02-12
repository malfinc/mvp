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

  before_validation :associate_current_account
  before_validation :associate_current_cart

  private def associate_current_account
    assign_attributes(account: account || current_account)
  end

  private def associate_current_cart
    carts << cart || current_cart
    (cart || current_cart).assign_attributes(billing_information: self)
  end
end
