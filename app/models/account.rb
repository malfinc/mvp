class Account < ApplicationRecord
  include Redis::Objects
  include FriendlyId

  has_many :recipes, dependent: :destroy, autosave: true

  validates_presence_of :login
  validates_format_of :login, with: /\A\w+\z/i

  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :validatable
  devise :confirmable
  devise :lockable
  devise :timeoutable

  friendly_id :email, use: [:slugged, :history], slug_column: :login
end
