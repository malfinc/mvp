defmodule Poutineer.Schema.Resolvers.Allergies do
  alias Poutineer.Repo
  alias Poutineer.Models.Allergy

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Allergy)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Allergy, arguments[:id])}
  end
end
