class PublicVersion < PaperTrail::Version
  self.table_name = :public_versions
  self.sequence_name = :public_versions_id_seq

  belongs_to :actor, :class_name => "Account", :optional => true
  belongs_to :item, :polymorphic => true
end
