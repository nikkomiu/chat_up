# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chat_up,
  ecto_repos: [ChatUp.Repo]

# Configures the endpoint
config :chat_up, ChatUp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cQaNG1xMqLKv6RcXTRFQjutCb1dHoozgHeW1sDkE1lFJqWHNgad1CKpZNP5Xq5dn",
  render_errors: [view: ChatUp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ChatUp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
