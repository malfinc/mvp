defmodule Poutineer.Graphql.Resolvers.PaymentTypes do
  
  

  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.PaymentType)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(PaymentType, id)}
  end
end
