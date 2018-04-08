class PaperTrail::VersionDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    item: Field::Polymorphic,
    event: Field::String,
    whodunnit: Field::String,
    actor_id: Field::String,
    transitions: Field::String.with_options(searchable: false),
    object: Field::String.with_options(searchable: false),
    object_changes: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :event,
    :whodunnit,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :event,
    :whodunnit,
    :transitions,
    :object,
    :object_changes,
    :created_at,
    :item,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
  ].freeze

  # Overwrite this method to customize how versions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(version)
  #   "PaperTrail::Version ##{version.id}"
  # end
end
