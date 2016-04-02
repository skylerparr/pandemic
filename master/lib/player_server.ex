defmodule PlayerServer do
  use ExActor.GenServer, export: :player_server

  defstart start_link, do: initial_state(%{})

  def create_player(name, secret) do
    create_player(%{name: name, secret: secret, cards: []})
  end

  defcall create_player(player), state: state do
    state = Map.put(state, player.secret, player)
    set_and_reply(state, player)
  end

  defcall get_player(secret), state: state do
    set_and_reply(state, Map.get(state, secret))
  end

  defcast drop_player(secret), state: state do
    new_state(Map.delete(state, secret))
  end

  defcast get_all_players, state: state, do: reply(state)
  
  defcast set_current_city(secret, city), state: state do
    player = Map.get(state, secret)
    player = Map.put(player, :current_city, city)
    state = Map.put(state, secret, player)
    GameServer.capture_action(secret)
    new_state(state)
  end

  defcast stop, do: stop_server(:normal)

  defcast reset, state: state, do: new_state(%{})
end

defmodule Player do
  defstruct name: "", secret: "", current_city: nil, cards: []
end
