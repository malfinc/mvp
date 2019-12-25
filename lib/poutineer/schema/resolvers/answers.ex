defmodule Poutineer.Schema.Resolvers.Answers do
  alias Poutineer.Repo
  alias Poutineer.Models.Answer

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Answer)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Answer, arguments[:id])}
  end
end
