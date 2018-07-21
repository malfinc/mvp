class PrivateVersion < PaperTrail::Version
  self.table_name = :private_versions

  belongs_to(:actor, :class_name => "Account", :optional => true)
  belongs_to(:item, :polymorphic => true)
end
