defmodule Poutineer.Graphql.Resolvers.Diets do
  
  

  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.Diet)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Diet, id)}
  end
end
