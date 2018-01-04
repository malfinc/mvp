class Recipe < ApplicationRecord
  include Redis::Objects
  include FriendlyId

  Gutentag::ActiveRecord.call self

  belongs_to :author, class_name: "Account"
  belongs_to :approver, class_name: "Account", optional: true
  belongs_to :publisher, class_name: "Account", optional: true
  belongs_to :denier, class_name: "Account", optional: true
  belongs_to :remover, class_name: "Account", optional: true

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

  value :queued_at, marshal: true
  value :published_at, marshal: true
  value :removed_at, marshal: true

  state_machine :state, initial: :draft do
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

    before_transition any => :queued do |record|
      record.queued_at = Time.zone.now
    end

    before_transition any => :published do |record|
      record.published_at = Time.zone.now
    end

    before_transition any => :removed do |record|
      record.removed_at = Time.zone.now
    end

    state :queued do
      validates_presence_of :queued_at
    end

    state :removed do
      validates_presence_of :removed_at
      validates_presence_of :remover
    end

    state :published do
      validates_presence_of :published_at
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
