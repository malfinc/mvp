class AccountDashboard < ApplicationDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    :versions => Field::HasMany.with_options(:class_name => "PaperTrail::Version"),
    :slugs => Field::HasMany.with_options(:class_name => "FriendlyId::Slug"),
    :recipes => Field::HasMany,
    :email => Field::Email,
    :username => Field::String,
    :role_state => Field::String,
    :onboarding_state => Field::String,
    :role_state_event => StateMachineField,
    :onboarding_state_event => StateMachineField,
    :reset_password_token => Field::String,
    :reset_password_sent_at => Field::DateTime,
    :remember_created_at => Field::DateTime,
    :confirmed_at => Field::DateTime,
    :confirmation_sent_at => Field::DateTime,
    :unconfirmed_email => Field::String,
    :failed_attempts => Field::Number,
    :locked_at => Field::DateTime,
    :created_at => Field::DateTime,
    :updated_at => Field::DateTime
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
    :onboarding_state,
    :created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :email,
    :username,
    :role_state,
    :onboarding_state,
    :created_at,
    :updated_at,
    :confirmed_at,
    :confirmation_sent_at,
    :locked_at,
    :reset_password_sent_at,
    :remember_created_at,
    :recipes,
    :slugs,
    :versions
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :email,
    :username,
    :role_state_event,
    :onboarding_state_event
  ].freeze

  # Overwrite this method to customize how accounts are displayed
  # across all pages of the admin dashboard.
  def display_resource(account)
    account.username
  end
end
