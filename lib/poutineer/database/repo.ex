defmodule Poutineer.Database.Repo do
  use Ecto.Repo,
    otp_app: :poutineer,
    adapter: Ecto.Adapters.Postgres
end
