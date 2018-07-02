class ApplicationRecord < ActiveRecord::Base
  include Redis::Objects
  include ArTransactionChanges

  self.abstract_class = true
  self.inheritance_column = "subtype"

  validates_presence_of :created_at, :on => :update
  validates_presence_of :updated_at, :on => :update

  private def actor
    Account.find(actor_id) if actor_id.present?
  end

  def actor_id
    PaperTrail.request.controller_info.fetch(:actor_id)
  end
end
