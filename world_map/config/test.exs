use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :world_map, WorldMap.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :world_map, WorldMap.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "world_map_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
