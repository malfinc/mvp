defmodule PoutineerWeb.Router do
  use PoutineerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug Poutineer.Plugs.GraphqlSessionContext
  end

  scope "/" do
    pipe_through :api

    forward "/", Absinthe.Plug,
      schema: Poutineer.Schema,
      before_send: {__MODULE__, :absinthe_before_send}
  end

  def absinthe_before_send(%Plug.Conn{method: "POST"} = connection, %Absinthe.Blueprint{} = blueprint) do
    Enum.reduce(blueprint.execution.context[:cookies] || [], connection, fn ([key, value], accumulation) ->
      Plug.Conn.put_session(accumulation, key, value)
    end)
  end

  def absinthe_before_send(connection, _), do: connection
end
