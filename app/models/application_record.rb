class ApplicationRecord < ActiveRecord::Base
  include Redis::Objects

  self.abstract_class = true
end
