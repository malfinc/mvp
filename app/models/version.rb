class Version < ActiveRecord::Base
  belongs_to :actor, :class_name => "Account", :optional => true
  belongs_to :item, :polymorphic => true

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end
end
