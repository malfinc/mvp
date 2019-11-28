# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :poutineer,
  ecto_repos: [Poutineer.Repo]

# Configures the endpoint
config :poutineer, PoutineerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JGuPqitGiv1A5WgWCxBQ8E2n7qzF8ThtUA/j0N1lfZzsvRv9VToPD4gADyCdbHaI",
  render_errors: [view: PoutineerWeb.ErrorView, accepts: ["json"]],
  pubsub: [name: Poutineer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
