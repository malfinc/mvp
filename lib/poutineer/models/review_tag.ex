defmodule Poutineer.Models.ReviewTag do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "reviews_tags" do
    belongs_to :review, Poutineer.Models.Review
    belongs_to :tag, Poutineer.Models.Tag
  end
end
