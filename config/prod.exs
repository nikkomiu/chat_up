use Mix.Config

config :chat_up, ChatUp.Endpoint,
  http: [host: "localhost", port: 8080],
  url: [host: "chatup.nikkomiu.com", port: 80],
  cache_static_manifest: "priv/static/manifest.json"

# Logging
config :logger, level: :info

# Releases
config :phoenix, :serve_endpoints, true
config :chat_up, ChatUp.Endpoint, root: "."

# Secret Key Base
config :chat_up, ChatUp.Endpoint,
  secret_key_base: "${SECRET_KEY_BASE}"

# Database
config :chat_up, ChatUp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "${DB_USER}",
  password: "${DB_PASS}",
  database: "${DB_BASE}",
  hostname: "${DB_HOST}",
  pool_size: 25

# Import secrets config
# import_config "prod.secret.exs"
