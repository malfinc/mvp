class Account < ApplicationRecord
  include FriendlyId
  include AuditedTransitions

  USERNAME_PATTERN = /\A[a-zA-Z0-9_-]+\z/i

  has_many :carts
  has_many :billing_informations
  has_many :delivery_informations
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

  state_machine :onboarding_state, initial: :fresh do
    event :complete do
      transition from: :fresh, to: :completed, if: :completable?
    end

    before_transition do: :version_transition
  end

  state_machine :role_state, initial: :guest do
    event :convert do
      transition from: :guest, to: :user
    end

    event :empower do
      transition user: :moderator
    end

    event :spark do
      transition user: :administrator
    end

    before_transition do: :version_transition
  end

  validates_presence_of :username, if: :email_required?
  validates_format_of :username, with: USERNAME_PATTERN, if: :email_required?

  def lock_access!(*)
    PaperTrail.request(whodunnit: "The Machine") do
      super
    end
  end

  def unlock_access!(*)
    PaperTrail.request(whodunnit: "The Machine") do
      super
    end
  end

  def valid_for_authentication?(*)
    PaperTrail.request.whodunnit = "The Machine"

    super
  end

  def unfinished_cart
    @unfinished_cart ||= carts.where.not(checkout_state: :completed).first || carts.create!
  end
  alias_method :create_unfinished_cart, :unfinished_cart

  private def generate_password
    assign_attributes(password: SecureRandom.hex(60))
  end

  private def generate_authentication_secret
    assign_attributes(authentication_secret: SecureRandom.hex(60))
  end

  private def email_required?
    onboarding_state?(:completed)
  end

  private def completable?
    email.present? && name.present?
  end
end
