class RecipeDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    author: Field::BelongsTo.with_options(class_name: "Account"),
    approver: Field::BelongsTo.with_options(class_name: "Account"),
    publisher: Field::BelongsTo.with_options(class_name: "Account"),
    denier: Field::BelongsTo.with_options(class_name: "Account"),
    remover: Field::BelongsTo.with_options(class_name: "Account"),
    slugs: Field::HasMany.with_options(class_name: "FriendlyId::Slug"),
    id: Field::String.with_options(searchable: false),
    name: Field::Text,
    slug: Field::String,
    state: Field::String,
    description: Field::Text,
    author_id: Field::String.with_options(searchable: false),
    approver_id: Field::String.with_options(searchable: false),
    publisher_id: Field::String.with_options(searchable: false),
    denier_id: Field::String.with_options(searchable: false),
    remover_id: Field::String.with_options(searchable: false),
    ingredients: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :author,
    :approver,
    :publisher,
    :denier,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :author,
    :approver,
    :publisher,
    :denier,
    :remover,
    :slugs,
    :id,
    :name,
    :slug,
    :state,
    :description,
    :author_id,
    :approver_id,
    :publisher_id,
    :denier_id,
    :remover_id,
    :ingredients,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :author,
    :approver,
    :publisher,
    :denier,
    :remover,
    :slugs,
    :name,
    :slug,
    :state,
    :description,
    :author_id,
    :approver_id,
    :publisher_id,
    :denier_id,
    :remover_id,
    :ingredients,
  ].freeze

  # Overwrite this method to customize how recipes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(recipe)
  #   "Recipe ##{recipe.id}"
  # end
end
