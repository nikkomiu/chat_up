defmodule ChatUp.Router do
  use ChatUp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatUp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/rooms", RoomController
    resources "/topics", TopicController, except: [:index] do
      resources "/messages", MessageController, except: [:show]
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", ChatUp.Api do
    pipe_through :api

    resources "/rooms", RoomController, except: [:new, :edit]
    resources "/topics", TopicController, except: [:index, :new, :edit] do
      resources "/messages", MessageController, except: [:new, :show, :edit]
    end
  end
end
