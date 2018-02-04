class Recipe < ApplicationRecord
  include Redis::Objects
  include FriendlyId

  Gutentag::ActiveRecord.call self

  belongs_to :author, class_name: "Account"
  belongs_to :approver, class_name: "Account", optional: true
  belongs_to :publisher, class_name: "Account", optional: true
  belongs_to :denier, class_name: "Account", optional: true
  belongs_to :remover, class_name: "Account", optional: true
  has_many :recipe_queue_state_transitions, dependent: :destroy

  validates_presence_of :slug
  validates_presence_of :ingredients
  validates_length_of :ingredients, minimum: 1
  validates_presence_of :author
  validates_presence_of :created_at, on: :update
  validates_presence_of :updated_at, on: :update

  before_validation on: :create do
    self.author ||= current_account
  end

  attr_accessor :current_account

  friendly_id :name, :use => [:slugged, :history]

  state_machine :queue_state, initial: :draft do
    audit_trail

    event :publish do
      transition :draft => :queued
    end

    event :publish do
      transition :draft => :published, if: :allowed_to_autopublish?
    end

    event :remove do
      transition :published => :draft, if: :allowed_to_remove?
    end

    event :deny do
      transition :queued => :draft, if: :allowed_to_deny?
    end

    event :approve do
      transition :queued => :published, if: :allowed_to_approve?
    end

    state :removed do
      validates_presence_of :remover
    end

    state :published do
      validates_presence_of :publisher
    end
  end

  private def should_generate_new_friendly_id?
    super || send("#{friendly_id_config.base}_changed?")
  end

  private def allowed_to_autopublish?
    current_account.verified? || current_account.moderator?
  end

  private def allowed_to_deny?
    current_account.administrator? || current_account.moderator?
  end

  private def allowed_to_approve?
    current_account.administrator? || current_account.moderator?
  end

  private def allowed_to_remove?
    current_account.administrator? || current_account.moderator?
  end
end
