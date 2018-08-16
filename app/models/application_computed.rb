class ApplicationComputed
  include(ActiveModel::Model)

  attr_accessor(:id)
  attr_accessor(:created_at)
  attr_accessor(:updated_at)

  def initialize(**attributes)
    self.id ||= attributes[:id] || SecureRandom.uuid()
    super(
      **attributes.merge(
        :created_at => if created_at.nil? then attributes.fetch(:created_at, Time.zone.now) end,
        :updated_at => Time.zone.now
      )
    )
  end
end
