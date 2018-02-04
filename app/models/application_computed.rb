class ApplicationComputed
  include ActiveModel::Model
  include Redis::Objects

  attr_accessor :id
  value :created_at
  value :updated_at

  def initialize(**attributes)
    self.id ||= attributes[:id] || SecureRandom.uuid()
    super(**attributes.merge(
      created_at: if created_at.nil? then attributes[:created_at] || Time.now end,
      updated_at: Time.now
    ))
  end
end
