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
  def changeset(%Poutineer.Models.Account{} = account, attributes \\ %{}) do
    account
      |> cast(attributes, [:email, :username, :name])
      |> validate_required([:email])
  end
end
