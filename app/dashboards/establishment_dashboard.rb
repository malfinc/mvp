class EstablishmentDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    :tags => Field::HasMany.with_options(:class_name => "Gutentag::Tag"),
    :versions => Field::HasMany.with_options(:class_name => "PaperTrail::Version"),
    :slugs => Field::HasMany.with_options(:class_name => "FriendlyId::Slug"),
    :menu_items => Field::HasMany,
    :payment_types => Field::HasMany,
    :name => Field::String,
    :slug => Field::String,
    :google_places_id => Field::String,
    :moderation_state_event => StateMachineField,
    :moderation_state => Field::String,
    :created_at => Field::DateTime,
    :updated_at => Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :moderation_state
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :slug,
    :moderation_state,
    :created_at,
    :updated_at,
    :payment_types,
    :menu_items,
    :tags,
    :slugs,
    :versions
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :google_places_id,
    :moderation_state_event
  ].freeze

  # Overwrite this method to customize how establishments are displayed
  # across all pages of the admin dashboard.
  def display_resource(establishment)
    establishment.name
  end
end
