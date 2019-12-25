defmodule Poutineer.Schema.Resolvers.Critiques do
  alias Poutineer.Repo
  alias Poutineer.Models.Critique

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Critique)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Critique, arguments[:id])}
  end
end
