defmodule Poutineer.Resolvers.Questions do
  alias Poutineer.Repo
  alias Poutineer.Models.Question

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Question)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Question, arguments[:id])}
  end
end
