class ApplicationRecord < ActiveRecord::Base
  include(Redis::Objects)
  include(ArTransactionChanges)

  self.abstract_class = true
  self.inheritance_column = "subtype"

  validates_presence_of(:created_at, :on => :update)
  validates_presence_of(:updated_at, :on => :update)

  def morph
    becomes(public_send(self.class.inheritance_column).constantize)
  end

  private def actor
    PaperTrail.request.whodunnit
  end

  def actor_id
    actor.id if actor.is_a?(Account)
  end
end
