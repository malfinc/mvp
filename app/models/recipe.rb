class Recipe < ApplicationRecord
  include Redis::Objects

  belongs_to :author, class_name: "User"
  belongs_to :approver, class_name: "User"
  belongs_to :denier, class_name: "User"
  belongs_to :remover, class_name: "User"

  validates_presence_of :ingredients
  validates_length_of :ingredients, minimum: 1
  validates_presence_of :user
  validates_presence_of :created_at
  validates_presence_of :updated_at

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
    end

    state :published do
      validates_presence_of :published_at
    end
  end

  private def allowed_to_autopublish?(record)
    record.author.verified? || record.author.moderator?
  end

  private def allowed_to_deny?(record)
    record.denier.moderator?
  end

  private def allowed_to_approve?(record)
    record.approver.moderator?
  end

  private def allowed_to_remove?(record)
    record.remover.moderator?
  end
end
