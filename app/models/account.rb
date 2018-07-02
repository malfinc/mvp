class Account < ApplicationRecord
  include FriendlyId
  include AuditedTransitions

  USERNAME_PATTERN = /\A[a-zA-Z0-9_\-\.]+\z/i

  has_many :recipes, :dependent => :destroy, :autosave => true, :foreign_key => :author_id, :inverse_of => :author

  friendly_id :email, :use => [:slugged, :history], :slug_column => :username

  devise :database_authenticatable
  devise :confirmable
  devise :lockable
  devise :recoverable
  devise :registerable
  devise :rememberable
  devise :validatable
  devise :async

  state_machine :onboarding_state, :initial => :converted do
    event :complete do
      transition :from => :converted, :to => :completed
    end

    before_transition :do => :version_transition
  end

  state_machine :role_state, :initial => :user do
    event :empower do
      transition :user => :moderator
    end

    event :spark do
      transition :user => :administrator
    end

    event :depower do
      transition :from => :moderator, :to => :user
    end

    event :despark do
      transition :from => :administrator, :to => :user
    end

    before_transition :do => :version_transition
    after_transition :on => :empower do |record|
      record.after_transaction do
        AccountRoleMailer.with(:destination => record).upgraded_to_moderator.deliver_now
      end
    end
    after_transition :on => :spark do |record|
      record.after_transaction do
        AccountRoleMailer.with(:destination => record).upgraded_to_administrator.deliver_now
      end
    end
    after_transition :on => :depower do |record|
      record.after_transaction do
        AccountRoleMailer.with(:destination => record).downgraded_to_user.deliver_now
      end
    end
    after_transition :on => :despark do |record|
      record.after_transaction do
        AccountRoleMailer.with(:destination => record).downgraded_to_user.deliver_now
      end
    end
  end

  before_validation :generate_password, :unless => :encrypted_password?
  before_validation :generate_authentication_secret, :unless => :authentication_secret?

  validates_presence_of :username, :if => :email_required?
  validates_format_of :username, :with => USERNAME_PATTERN, :if => :email_required?

  private def generate_password
    assign_attributes(:password => SecureRandom.hex(60))
  end

  private def generate_authentication_secret
    assign_attributes(:authentication_secret => SecureRandom.hex(60))
  end

  private def email_required?
    onboarding_state?(:converted) || onboarding_state?(:completed)
  end

  private def account_confirmed
    complete! if onboarding_state?(:converted) && can_complete?
  end
end
