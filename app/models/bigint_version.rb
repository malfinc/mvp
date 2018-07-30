class BigintVersion < PaperTrail::Version
  self.table_name = :bigint_versions

  belongs_to(:actor, :class_name => "Account", :optional => true)
  belongs_to(:item, :polymorphic => true)
end
