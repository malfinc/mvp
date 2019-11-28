use Mix.Config

# Configure your database
config :poutineer, Poutineer.Repo,
  username: "postgres",
  password: "postgres",
  database: "poutineer_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :poutineer, PoutineerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
