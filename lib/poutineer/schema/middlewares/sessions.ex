defmodule Poutineer.Schema.Middlewares.Sessions do
  def update_session_id(%{value: %{id: String = id}} = resolution, _) do
    Map.merge(resolution, %{context: Map.merge(resolution.context, %{cookies: [[:session_id, id]]})})
  end
  def update_session_id(resolution, _), do: resolution

  def require_authentication(%{current_account: nil} = resolution, _), do: resolution |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
  def require_authentication(resolution, _), do: resolution
end
