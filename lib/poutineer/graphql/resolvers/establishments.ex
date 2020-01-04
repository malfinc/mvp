defmodule Poutineer.Graphql.Resolvers.Establishments do
  
  

  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Database.Repo.all(Poutineer.Models.Establishment)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Database.Repo.get(Establishment, id)}
  end
end
