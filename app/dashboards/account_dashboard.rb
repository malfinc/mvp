class AccountDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    recipes: Field::HasMany,
    approved_recipes: Field::HasMany.with_options(class_name: "Recipe"),
    published_recipes: Field::HasMany.with_options(class_name: "Recipe"),
    denied_recipes: Field::HasMany.with_options(class_name: "Recipe"),
    removed_recipes: Field::HasMany.with_options(class_name: "Recipe"),
    slugs: Field::HasMany.with_options(class_name: "FriendlyId::Slug"),
    id: Field::String.with_options(searchable: false),
    email: Field::Email,
    username: Field::Text,
    role_state: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    failed_attempts: Field::Number,
    unlock_token: Field::String,
    locked_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :email,
    :username,
    :role_state,
    :created_at,
    :recipes,
  ].freeze


  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :email,
    :username,
    :role_state,
    :failed_attempts,
    :locked_at,
    :reset_password_sent_at,
    :remember_created_at,
    :confirmed_at,
    :confirmation_sent_at,
    :created_at,
    :updated_at,
    :slugs,
    :recipes,
    :approved_recipes,
    :published_recipes,
    :denied_recipes,
    :removed_recipes,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :email,
    :username,
  ].freeze

  # Overwrite this method to customize how accounts are displayed
  # across all pages of the admin dashboard.
  def display_resource(account)
    account.username
  end
end
