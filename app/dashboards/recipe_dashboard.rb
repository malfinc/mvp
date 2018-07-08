class RecipeDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    :tags => Field::HasMany.with_options(:class_name => "Gutentag::Tag"),
    :public_versions => Field::HasMany.with_options,
    :slugs => Field::HasMany.with_options(:class_name => "FriendlyId::Slug"),
    :author => Field::BelongsTo.with_options(:class_name => "Account"),
    :diets => Field::HasMany,
    :allergies => Field::HasMany,
    :name => Field::String,
    :slug => Field::String,
    :description => Field::Text,
    :moderation_state => Field::String,
    :prep_time => Field::Number,
    :cook_time => Field::Number,
    :moderation_state_event => StateMachineField,
    :ingredients => ArrayOfTextField,
    :instructions => ArrayOfTextField,
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
    :author,
    :moderation_state
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :slug,
    :name,
    :description,
    :ingredients,
    :instructions,
    :cook_time,
    :prep_time,
    :diets,
    :allergies,
    :moderation_state,
    :created_at,
    :updated_at,
    :author,
    :tags,
    :slugs,
    :versions
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :description,
    :cook_time,
    :prep_time,
    :diets,
    :allergies,
    :moderation_state_event
  ].freeze

  # Overwrite this method to customize how recipes are displayed
  # across all pages of the admin dashboard.
  def display_resource(recipe)
    recipe.name.inspect
  end
end
