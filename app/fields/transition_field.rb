class TransitionField < Administrate::Field::Base
  def object
    data
  end

  def headers
    object.keys
  end

  def values
    object.values
  end

  def any?
    object.present? && object.any?
  end
end
