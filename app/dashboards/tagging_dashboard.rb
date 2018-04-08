class Gutentag::TaggingDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    tag: Field::BelongsTo.with_options(class_name: "Gutentag::Tag"),
    taggable: Field::Polymorphic,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :tag,
    :taggable,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :created_at,
    :updated_at,
    :tag,
    :taggable,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :tag,
    :taggable,
  ].freeze

  # Overwrite this method to customize how taggings are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(tagging)
  #   "Gutentag::Tagging ##{tagging.id}"
  # end
end
