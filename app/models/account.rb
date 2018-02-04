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
  devise :timeoutable
  devise :validatable
  devise :async

  before_validation :generate_password, unless: :encrypted_password?
  before_validation :generate_authentication_secret, unless: :authentication_secret?

  state_machine :role_state, initial: :user do
    audit_trail initial: false, context: :audit_actor_id

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

  def current_cart
    @current_cart ||= carts.find_or_create_by(checkout_state: :fresh)
  end

  private def generate_password
    assign_attributes(password: SecureRandom.hex(120))
  end

  private def generate_authentication_secret
    assign_attributes(authentication_secret: SecureRandom.hex(120))
  end
end
