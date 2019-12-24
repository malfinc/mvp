defmodule Poutineer.Resolvers.PaymentTypes do
  alias Poutineer.Repo
  alias Poutineer.Models.PaymentType

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(PaymentType)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(PaymentType, arguments[:id])}
  end
end
