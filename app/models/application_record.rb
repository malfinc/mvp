class ApplicationRecord < ActiveRecord::Base
  include Redis::Objects
  include ArTransactionChanges

  self.abstract_class = true
  self.inheritance_column = "subtype"

  private def actor
    PaperTrail.request.whodunnit
  end

  def actor_id
    actor.id if actor.kind_of?(Account)
  end
end
