defmodule Poutineer.Graphql.Resolvers.Answers do
  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.Answer)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Answer, id)}
  end
end
