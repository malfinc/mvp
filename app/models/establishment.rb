class Establishment < ApplicationRecord
  include FriendlyId
  include Moderated

  has_many :menu_items, :dependent => :destroy
  has_and_belongs_to_many :payment_types

  Gutentag::ActiveRecord.(self)

  friendly_id :name, :use => [:slugged, :history]

  validates_presence_of :name
  validates_presence_of :slug
  validates_presence_of :google_places_id

  after_commit :google_places_backfill, :on => :create

  def contributors
    Account.with_role_state(:user).where(:id => versions.where.not(:actor_id => nil).select(:actor_id))
  end

  private def google_places_backfill
    GooglePlacesBackfillJob.perform_async(id)
  end
end