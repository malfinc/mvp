class Account < ApplicationRecord
  include Redis::Objects

  has_many :recipes, dependent: :destroy, autosave: true


  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :validatable
  devise :confirmable
  devise :lockable
  devise :timeoutable

end
