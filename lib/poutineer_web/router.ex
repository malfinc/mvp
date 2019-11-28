defmodule PoutineerWeb.Router do
  use PoutineerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PoutineerWeb do
    pipe_through :api
    # resources "/accounts", AccountController, except: [:new, :edit]
    # resources "/reviews", ReviewController, except: [:new, :edit]
    # resources "/companies", CompanyController, except: [:new, :edit]
    # resources "/companies", CompanyController, except: [:new, :edit]
  end
end
