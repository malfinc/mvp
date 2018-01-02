class Account < ApplicationRecord
  include Redis::Objects
  include FriendlyId

  USERNAME_PATTERN = /\A[a-zA-Z0-9_-]+\z/i

  has_many :recipes, dependent: :destroy, autosave: true, foreign_key: :author_id
  has_many :approved_recipes, class_name: "Recipe", foreign_key: :approver_id
  has_many :published_recipes, class_name: "Recipe", foreign_key: :publisher_id
  has_many :denied_recipes, class_name: "Recipe", foreign_key: :denier_id
  has_many :removed_recipes, class_name: "Recipe", foreign_key: :remover_id

  friendly_id :email, use: [:slugged, :history], slug_column: :username

  devise :database_authenticatable
  devise :confirmable
  devise :lockable
  devise :recoverable
  devise :registerable
  devise :rememberable
  devise :timeoutable
  devise :validatable

  state_machine :state, initial: :user do
    event :empower do
      transition user: :moderator
    end

    state :user do
      validates_presence_of :username
      validates_format_of :username, with: USERNAME_PATTERN

      def user?
        true
      end
    end

    state :moderator do
      validates_presence_of :username
      validates_format_of :username, with: USERNAME_PATTERN

      def moderator?
        true
      end
    end

    state :administrator do
      validates_presence_of :username
      validates_format_of :username, with: USERNAME_PATTERN

      def administrator?
        true
      end
    end
  end
end
