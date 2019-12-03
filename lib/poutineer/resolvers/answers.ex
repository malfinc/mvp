defmodule Poutineer.Resolvers.Answers do
  alias Poutineer.Repo
  alias Poutineer.Models.Answer

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Answer)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Answer, arguments[:id])}
  end

  # def create(_parent, arguments, _resolution) do
  #   password = :crypto.strong_rand_bytes(24)
  #     |> Base.encode32(case: :upper)
  #     |> binary_part(0, 24)
  #
  #   Review.changeset(%Review{}, Map.merge(%{password: password, confirm_password: password}, arguments))
  #     |> case do
  #       %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
  #       %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
  #     end
  # end
end
