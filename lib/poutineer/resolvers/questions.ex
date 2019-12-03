defmodule Poutineer.Resolvers.Questions do
  alias Poutineer.Repo
  alias Poutineer.Models.Question

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Question)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Question, arguments[:id])}
  end

  # def create(_parent, arguments, _resolution) do
  #   password = :crypto.strong_rand_bytes(24)
  #     |> Base.encode32(case: :upper)
  #     |> binary_part(0, 24)
  #
  #   Question.changeset(%Question{}, Map.merge(%{password: password, confirm_password: password}, arguments))
  #     |> case do
  #       %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
  #       %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
  #     end
  # end
end
