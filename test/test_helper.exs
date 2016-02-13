ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Hydchat.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Hydchat.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Hydchat.Repo)

