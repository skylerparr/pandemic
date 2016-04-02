ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Login.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Login.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Login.Repo)

