defmodule GameServer do
  use ExActor.GenServer, export: :game_server

  defstart start_link, do: initial_state(0)

  defcast capture_action(secret), state: state do
    WorldMap.update_player(secret)

    move_count = state + 1
    if(move_count == 4) do
      move_count = 0
    end
    new_state(move_count)
  end
end
