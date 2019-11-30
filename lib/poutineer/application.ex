defmodule Poutineer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    unless Mix.env == :prod do
      Envy.auto_load
    end

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Poutineer.Repo,
      # Start the endpoint when the application starts
      PoutineerWeb.Endpoint,
      # Starts a worker by calling: Poutineer.Worker.start_link(arg)
      # {Poutineer.Worker, arg},
      {Absinthe.Subscription, [PoutineerWeb.Endpoint]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Poutineer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PoutineerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
