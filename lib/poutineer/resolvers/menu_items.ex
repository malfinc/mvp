defmodule Poutineer.Resolvers.MenuItems do
  alias Poutineer.Repo
  alias Poutineer.Models.MenuItem

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(MenuItem)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(MenuItem, arguments[:id])}
  end
end
