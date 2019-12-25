defmodule Poutineer.Models.Account do
  use Ecto.Schema
  import Ecto.Changeset

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
    has_many :reviews, Poutineer.Models.Review, foreign_key: :author_id
    has_many :recipes, Poutineer.Models.Recipe, foreign_key: :author_id
    has_many :critiques, Poutineer.Models.Critique, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(%Poutineer.Models.Account{} = record, attributes \\ %{}) do
    record
      |> optionally_handle_password_hash(attributes)
      |> optionally_handle_unconfirmed_email(attributes)
      |> cast(attributes, [:email, :username, :name, :password_hash])
      |> validate_required([:email])
      |> unique_constraint(:email)
      |> unique_constraint(:username)
  end

  defp optionally_handle_password_hash(record, attributes) do
    if attributes.password do
      Ecto.Changeset.change(record, Argon2.add_hash(attributes.password))
    else
      record
    end
  end

  defp optionally_handle_unconfirmed_email(record, attributes) do
    if attributes.email do
      Ecto.Changeset.change(record, %{unconfirmed_email: attributes.email})
    else
      record
    end
  end
end
