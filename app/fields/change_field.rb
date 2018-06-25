class ChangeField < Administrate::Field::Base
  def object
    data.without(*options[:without_headers])
  end

  def headers
    object.keys
  end

  delegate :values, :to => :object

  delegate :any?, :to => :object
end
