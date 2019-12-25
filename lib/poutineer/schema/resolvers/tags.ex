defmodule Poutineer.Schema.Resolvers.Tags do
  alias Poutineer.Repo
  alias Poutineer.Models.Tag

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Tag)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Tag, arguments[:id])}
  end
end
