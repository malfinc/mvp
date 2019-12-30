defmodule Poutineer.Schema.Middlewares.Sessions do
  def update_session_id(resolution, _) do
    case resolution do
      %{value: %{id: id}} ->
        Map.merge(resolution, %{context: Map.merge(resolution.context, %{cookies: [[:session_id, id]]})})
      _ ->
        resolution
    end
  end

  def require_authentication(resolution, _) do
    case resolution do
      %{context: %{current_account: _}} ->
        resolution
      _ ->
        resolution |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
    end
  end
end
