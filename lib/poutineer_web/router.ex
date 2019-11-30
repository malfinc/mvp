defmodule PoutineerWeb.Router do
  use PoutineerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/", Absinthe.Plug,
      schema: Poutineer.Schema
  end

end
