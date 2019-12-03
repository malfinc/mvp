defmodule Poutineer.Models.Account do
  use Ecto.Schema
  use Pow.Ecto.Schema
  # use Pow.Extension.Ecto.Schema,
  #   extensions: [PowResetPassword, PowEmailConfirmation]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    pow_user_fields()

    timestamps()
  end

  def changeset(account_or_changeset, attributes \\ %{}) do
    account_or_changeset
      |> pow_changeset(attributes)
      # |> pow_extension_changeset(attributes)
  end
end
