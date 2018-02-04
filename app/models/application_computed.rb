class ApplicationComputed
  include ActiveModel::Model
  include Redis::Objects

  attr_accessor :id
  value :created_at

  def initialize(*)
    super
    self.id ||= SecureRandom.uuid()
    self.created_at = Time.now if created_at.nil?
  end

  def updated_at
    @updated_at = Time.now
  end
end
