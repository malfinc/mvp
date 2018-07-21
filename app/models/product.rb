class Product < ApplicationRecord
  PAPER_TRAIL_MODEL = "PublicVersion".freeze

  include(FriendlyId)
  include(AuditedTransitions)

  has_many(:cart_items, :dependent => nil)

  friendly_id(:name, :use => [:slugged, :history], :slug_column => :slug)

  monetize(:price_cents)

  validates_presence_of(:name)
  validates_presence_of(:description)
  validates_presence_of(:price)
  validates_presence_of(:price_cents)
  validates_presence_of(:price_currency)
  validates_presence_of(:metadata, :on => :update)
  validates_presence_of(:slug)
  validates_presence_of(:visibility_state)
  validates_presence_of(:checksum)

  before_validation(:generate_checksum)

  state_machine(:visibility_state, :initial => :hidden) do
    event(:hide) do
      transition(:visible => :hidden)
    end

    event(:show) do
      transition(:hidden => :visible)
    end

    before_transition(:do => :version_transition)
  end

  private def generate_checksum
    assign_attributes(:checksum => metadata.hash)
  end
end
