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
  def changeset(%{} = record, attributes \\ %{}) do
    record
      |> Ecto.Changeset.change()
      |> set_password_hash_if_changing_password(attributes)
      |> replace_email_with_unconfirmed_email(attributes)
      |> cast(attributes, [:email, :username, :name, :password_hash, :unconfirmed_email])
      |> validate_required([:email])
      |> unique_constraint(:email)
      |> unique_constraint(:username)
  end

  defp set_password_hash_if_changing_password(%Ecto.Changeset{} = changeset, %{password: password}) do
    Ecto.Changeset.change(changeset, Argon2.add_hash(password))
  end
  defp set_password_hash_if_changing_password(%Ecto.Changeset{} = changeset, _), do: changeset

  # If have email, given email, and not the same then remove given email and update unconfirmed
  # If have email, given email, and the same then remove given email and return changeset
  defp replace_email_with_unconfirmed_email(%Ecto.Changeset{changes: %Poutineer.Models.Account{email: recorded_email}} = changeset, %{email: unconfirmed_email} = attributes) when is_bitstring(recorded_email) and is_bitstring(unconfirmed_email) do
    Map.delete(attributes, :email)

    if unconfirmed_email != recorded_email do
      Ecto.Changeset.change(changeset, %{unconfirmed_email: unconfirmed_email})
    else
      changeset
    end
  end
  # If have no email, and given email, remove given email and update confirmed
  defp replace_email_with_unconfirmed_email(%Ecto.Changeset{data: %Poutineer.Models.Account{email: nil}} = changeset, %{email: unconfirmed_email} = attributes) when is_bitstring(unconfirmed_email) do
    Map.delete(attributes, :email)

    Ecto.Changeset.change(changeset, %{unconfirmed_email: unconfirmed_email})
  end
  # If maybe have email and given no email then return changeset
  defp replace_email_with_unconfirmed_email(%Ecto.Changeset{} = changeset, _), do: changeset
end
