class ApplicationComputed
  include ActiveModel::Model

  attr_accessor :id
  attr_accessor :created_at
  attr_accessor :updated_at

  def initialize(**attributes)
    self.id ||= attributes[:id] || SecureRandom.uuid
    super(
      **attributes.merge(
        :created_at => attributes[:created_at] || Time.now if created_at.nil?,
        :updated_at => Time.now
      )
    )
  end
end
