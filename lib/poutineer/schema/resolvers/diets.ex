defmodule Poutineer.Schema.Resolvers.Diets do
  alias Poutineer.Repo
  alias Poutineer.Models.Diet

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Diet)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Diet, arguments[:id])}
  end
end
