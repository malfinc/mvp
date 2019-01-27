class Cart < ApplicationRecord
  include(AuditedWithTransitions)

  belongs_to(:account)
  has_many(:payments)

  state_machine(:sale_state, :initial => :pending) do
    event(:close) do
      transition(:from => :pending, :to => :closed)
    end

    event(:purchased) do
      transition(:from => :pending, :to => :purchased)
    end

    before_transition(:do => :version_transition)
  end
end
