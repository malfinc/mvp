class ApplicationRecord < ActiveRecord::Base
  include Redis::Objects
  include ArTransactionChanges

  self.abstract_class = true
end
