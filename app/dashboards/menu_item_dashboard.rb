class MenuItemDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    tags: Field::HasMany.with_options(class_name: "Gutentag::Tag"),
    versions: Field::HasMany.with_options(class_name: "PaperTrail::Version"),
    slugs: Field::HasMany.with_options(class_name: "FriendlyId::Slug"),
    diets: Field::HasMany,
    allergies: Field::HasMany,
    establishment: Field::HasOne,
    name: Field::String,
    slug: Field::String,
    description: Field::String,
    moderation_state: Field::String,
    moderation_state_event: StateMachineField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :establishment,
    :moderation_state,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :slug,
    :description,
    :moderation_state,
    :created_at,
    :updated_at,
    :diets,
    :allergies,
    :establishment,
    :tags,
    :slugs,
    :versions,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :description,
    :diets,
    :allergies,
    :moderation_state_event,
  ].freeze

  # Overwrite this method to customize how menu items are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(menu_item)
    menu_item.name
  end
end
