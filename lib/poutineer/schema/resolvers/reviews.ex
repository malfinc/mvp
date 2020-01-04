defmodule Poutineer.Schema.Resolvers.Reviews do
  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.Review)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Review, id)}
  end
end
