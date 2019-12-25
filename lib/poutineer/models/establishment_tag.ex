defmodule Poutineer.Models.EstablishmentTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishments_tags" do
    belongs_to :establishment, Poutineer.Models.Establishment
    belongs_to :tag, Poutineer.Models.Tag
  end
end
