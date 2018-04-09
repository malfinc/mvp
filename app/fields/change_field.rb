class ChangeField < Administrate::Field::Base
  def object
    data.without(*@options[:without_headers])
  end

  def headers
    object.keys
  end

  def values
    object.values
  end

  def any?
    object.any?
  end
end
