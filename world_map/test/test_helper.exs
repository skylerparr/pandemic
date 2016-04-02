ExUnit.start

Mix.Task.run "ecto.create", ~w(-r WorldMap.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r WorldMap.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(WorldMap.Repo)

