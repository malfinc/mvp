defmodule Poutineer.Models.EstablishmentTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "establishments_tags" do
    belongs_to :establishment, Poutineer.Models.Establishment, primary_key: true
    belongs_to :tag, Poutineer.Models.Tag, primary_key: true
  end
end
