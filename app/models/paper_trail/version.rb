class PaperTrail::Version < ::ActiveRecord::Base
  include PaperTrail::VersionConcern

  belongs_to :actor, :class_name => "Account", :optional => true
  belongs_to :item, :polymorphic => true

  def actor
    if super.is_a?(ActiveRecord::Base)
      super
    else
      ActorNull.new(:name => whodunnit, :username => whodunnit)
    end
  end
end
