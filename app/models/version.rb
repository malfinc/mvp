class Version < ApplicationRecord
  self.primary_key = :id
  belongs_to(:actor, :class_name => "Account", :optional => true)
  belongs_to(:item, :polymorphic => true)

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end

  def actor
    if actor_id.present?
      super
    else
      ActorNull.new(:id => 0, :name => whodunnit, :username => whodunnit, :email => whodunnit)
    end
  end
end
