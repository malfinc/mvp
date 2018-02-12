class Account < ApplicationRecord
  include FriendlyId
  include AuditActor

  USERNAME_PATTERN = /\A[a-zA-Z0-9_-]+\z/i

  has_many :account_role_state_transitions
  has_many :carts
  has_many :billing_informations
  has_many :shipping_informations
  has_many :payments

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
    audit_trail initial: false, context: :audit_actor_id

    event :convert do
      transition from: :fresh, to: :converted
    end

    event :complete do
      transition from: :converted, to: :completed
    end
  end

  state_machine :role_state, initial: :user do
    audit_trail initial: false, context: :audit_actor_id

    event :empower do
      transition user: :moderator
    end

    event :spark do
      transition user: :administrator
    end
  end

  def fresh_cart
    @fresh_cart ||= carts.find_or_create_by!(checkout_state: :fresh)
  end
  alias_method :build_fresh_cart, :fresh_cart

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
