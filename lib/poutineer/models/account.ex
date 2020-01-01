defmodule Poutineer.Models.Account do
  use Ecto.Schema
  import Estate, only: [machine: 1]
  import Ecto.Changeset

  machine([
    onboarding_state: [complete: [converted: "completed"]],
    role_state: [
      grant_moderation_powers: [user: "moderator"],
      grant_administrator_powers: [user: "administrator", moderator: "administrator"]
    ]
  ])

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :unconfirmed_email, :string
    field :username, :string
    field :name, :string
    field :onboarding_state, :string, default: "converted"
    field :role_state, :string, default: "user"
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :reviews, Poutineer.Models.Review, foreign_key: :author_account_id
    has_many :recipes, Poutineer.Models.Recipe, foreign_key: :author_account_id
    has_many :critiques, Poutineer.Models.Critique, foreign_key: :author_account_id

    timestamps()
  end

  def unconfirmed?(%Poutineer.Models.Account{unconfirmed_email: _}), do: true
  def unconfirmed?(_), do: false

  @doc false
  def changeset(%Poutineer.Models.Account{} = record, attributes \\ %{}) do
    record
      |> set_password_hash_if_changing_password(attributes)
      |> replace_email_with_unconfirmed_email(attributes)
      |> cast(attributes, [:email, :username, :name, :password_hash])
      |> validate_required([:email])
      |> unique_constraint(:email)
      |> unique_constraint(:username)
  end

  defp set_password_hash_if_changing_password(record, attributes) do
    if attributes.password do
      Ecto.Changeset.change(record, Argon2.add_hash(attributes.password))
    else
      record
    end
  end

  defp replace_email_with_unconfirmed_email(record, attributes) do
    email = attributes.email

    if email && !record.email do
      Map.delete(attributes, :email)
    end

    if email != record.email do
      Ecto.Changeset.change(record, %{unconfirmed_email: email})
    else
      record
    end
  end
end
