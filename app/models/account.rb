class Account < ApplicationRecord
  include FriendlyId
  include AuditedTransitions

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
  devise :validatable
  devise :async

  before_validation :generate_password, unless: :encrypted_password?
  before_validation :generate_authentication_secret, unless: :authentication_secret?

  validates_presence_of :username, if: :email_required?
  validates_format_of :username, with: USERNAME_PATTERN, if: :email_required?

  state_machine :onboarding_state, initial: :fresh do
    event :convert do
      transition from: :fresh, to: :converted
    end

    event :complete do
      transition from: :converted, to: :completed
    end

    before_transition do: :version_transition
  end

  state_machine :role_state, initial: :user do
    event :empower do
      transition user: :moderator
    end

    event :spark do
      transition user: :administrator
    end

    before_transition do: :version_transition
  end

  private def generate_password
    assign_attributes(password: SecureRandom.hex(60))
  end

  private def generate_authentication_secret
    assign_attributes(authentication_secret: SecureRandom.hex(60))
  end

  private def email_required?
    onboarding_state?(:converted) || onboarding_state?(:completed)
  end
end
