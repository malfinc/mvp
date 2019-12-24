defmodule Poutineer.Resolvers.Establishments do
  alias Poutineer.Repo
  alias Poutineer.Models.Establishment

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Establishment)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Establishment, arguments[:id])}
  end
end
