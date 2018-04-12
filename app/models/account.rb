class Account < ApplicationRecord
  include FriendlyId
  include AuditedTransitions

  USERNAME_PATTERN = /\A[a-zA-Z0-9_-]+\z/i

  has_many :recipes, dependent: :destroy, autosave: true, foreign_key: :author_id

  friendly_id :email, use: [:slugged, :history], slug_column: :username

  devise :database_authenticatable
  devise :confirmable
  devise :lockable
  devise :recoverable
  devise :registerable
  devise :rememberable
  devise :validatable
  devise :async

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

    event :depower do
      transition from: :moderator, to: :user
    end

    event :despark do
      transition from: :administrator, to: :user
    end

    before_transition do: :version_transition
  end

  before_validation :generate_password, unless: :encrypted_password?
  before_validation :generate_authentication_secret, unless: :authentication_secret?

  validates_presence_of :username, if: :email_required?
  validates_format_of :username, with: USERNAME_PATTERN, if: :email_required?

  # Lock a user setting its locked_at to actual time.
  # * +opts+: Hash options if you don't want to send email
  #   when you lock access, you could pass the next hash
  #   `{ send_instructions: false } as option`.
  def lock_access!(opts = { })
    self.locked_at = Time.now.utc

    if unlock_strategy_enabled?(:email) && opts.fetch(:send_instructions, true)
      send_unlock_instructions
    else
      PaperTrail.requet(whodunnit: "The Machine") do
        save(validate: false)
      end
    end
  end

  # Unlock a user by cleaning locked_at and failed_attempts.
  def unlock_access!
    self.locked_at = nil
    self.failed_attempts = 0 if respond_to?(:failed_attempts=)
    self.unlock_token = nil  if respond_to?(:unlock_token=)
    PaperTrail.requet(whodunnit: "The Machine") do
      save(validate: false)
    end
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
