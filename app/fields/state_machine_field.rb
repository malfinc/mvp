require("administrate/field/base")

class StateMachineField < Administrate::Field::Base
  def to_s
    data
  end

  def selectable_options
    collection
  end

  def any?
    resource.public_send(attribute.to_s.pluralize.to_s).any?
  end

  def prompt
    options.fetch(:prompt, "Select an event to fire")
  end

  private def collection
    @collection ||= options.fetch(:collection, resource.public_send(attribute.to_s.pluralize.to_s))
  end
end
