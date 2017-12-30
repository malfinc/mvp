require "administrate/base_dashboard"

class RecipeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    author: Field::BelongsTo.with_options(class_name: "User"),
    approver: Field::BelongsTo.with_options(class_name: "User"),
    denier: Field::BelongsTo.with_options(class_name: "User"),
    remover: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::String.with_options(searchable: false),
    name: Field::Text,
    description: Field::Text,
    author_id: Field::String.with_options(searchable: false),
    approver_id: Field::String.with_options(searchable: false),
    denier_id: Field::String.with_options(searchable: false),
    remover_id: Field::String.with_options(searchable: false),
    ingredients: Field::Text,
    state: Field::String,
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
    :denier,
    :remover,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :author,
    :approver,
    :denier,
    :remover,
    :id,
    :name,
    :description,
    :author_id,
    :approver_id,
    :denier_id,
    :remover_id,
    :ingredients,
    :state,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :author,
    :approver,
    :denier,
    :remover,
    :name,
    :description,
    :author_id,
    :approver_id,
    :denier_id,
    :remover_id,
    :ingredients,
    :state,
  ].freeze

  # Overwrite this method to customize how recipes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(recipe)
  #   "Recipe ##{recipe.id}"
  # end
end
