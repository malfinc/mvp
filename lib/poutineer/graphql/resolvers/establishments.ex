defmodule Poutineer.Graphql.Resolvers.Establishments do
  
  

  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.Establishment)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Establishment, id)}
  end
end
