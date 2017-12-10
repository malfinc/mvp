class Account < ApplicationRecord
  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :validatable
  devise :confirmable
  devise :lockable
  devise :timeoutable
end
