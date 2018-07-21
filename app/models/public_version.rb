class PublicVersion < PaperTrail::Version
  self.table_name = :public_versions

  belongs_to(:actor, :class_name => "Account", :optional => true)
  belongs_to(:item, :polymorphic => true)
end
