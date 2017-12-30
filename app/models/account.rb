class Account < ApplicationRecord
  include Redis::Objects

  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :validatable
  devise :confirmable
  devise :lockable
  devise :timeoutable

  has_many :recipes
end
