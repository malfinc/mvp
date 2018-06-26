class TransitionField < Administrate::Field::Base
  def object
    data
  end

  def headers
    object.keys
  end

  delegate :values, :to => :object

  def any?
    object.present? && object.any?
  end
end
