defmodule Poutineer.Plugs.GraphqlSessionContext do
  @behaviour Plug

  def init(opts), do: opts

  def call(%Plug.Conn{method: "POST"} = connection, _) do
    session_id = Plug.Conn.get_session(connection, :session_id)

    account = if session_id do
      Poutineer.Repo.get(Poutineer.Models.Account, session_id)
    end

    Absinthe.Plug.put_options(
      connection,
      context: %{
        current_account: account
      }
    )
  end

  def call(connection, _), do: connection
end
