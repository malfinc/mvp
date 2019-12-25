defmodule Poutineer.Schema.Resolvers.Reviews do
  alias Poutineer.Repo
  alias Poutineer.Models.Review

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Review)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Review, arguments[:id])}
  end
end
