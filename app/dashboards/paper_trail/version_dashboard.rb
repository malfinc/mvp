class PaperTrail::VersionDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    :item_type => Field::String,
    :item => Field::Polymorphic,
    :event => Field::String,
    :group_id => Field::String,
    :actor => Field::BelongsTo.with_options(:class_name => "Account"),
    :transitions => TransitionField,
    :object => ChangeField,
    :object_changes => ChangesetField,
    :created_at => Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :actor,
    :event,
    :group_id,
    :item_type,
    :item
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :group_id,
    :event,
    :transitions,
    :object_changes,
    :created_at,
    :actor,
    :item,
    :object
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
  ].freeze

  # Overwrite this method to customize how versions are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(version)
    "Change to #{version.item_type} by #{version.actor.name}"
  end
end
