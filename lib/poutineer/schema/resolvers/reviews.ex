defmodule Poutineer.Schema.Resolvers.Reviews do
  def list(_parent, _arguments, _resolution) do
    {:ok, Poutineer.Repo.all(Poutineer.Models.Review)}
  end

  def fetch(_parent, %{id: id}, _resolution) when not is_nil(id) do
    {:ok, Poutineer.Repo.get(Review, id)}
  end

  def create(_parent, arguments, %{context: %{current_account: %Poutineer.Models.Account{id: id}}}) when not is_nil(id) do
    %Poutineer.Models.Review{}
      |> Poutineer.Models.Review.changeset(Map.merge(arguments, %{author_account_id: id}))
      |> case do
        %Ecto.Changeset{valid?: true} = changeset -> Poutineer.Repo.insert(changeset)
        %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
      end
  end
end
