defmodule GameUpdater do
  use ExActor.GenServer, export: :game_updater

  defstart start_link, do: initial_state(%{player_locations: %{}, sockets: []})

  defcast register_socket(socket), state: state do
    sockets = Map.get(state, :sockets)
    sockets = [socket | sockets]
    state = Map.put(state, :sockets, sockets)
    new_state(state)
  end

  defcast update_player(player), state: state do
    player_locations = Map.get(state, :player_locations)
    old_player = Map.get(player_locations, player.secret)

    if(old_player != nil) do
      remove_player_location(Map.get(state, :sockets), old_player)  
    end
    set_player_location(Map.get(state, :sockets), player)
    
    player_locations = Map.put(player_locations, player.secret, player)
    state = Map.put(state, :player_locations, player_locations)
    new_state(state)
  end

  defcast reset, state: state, do: %{} |> new_state

  defcall get_sockets, state: state, do: reply(Map.get(state, :sockets))

  def send_event do
    sockets = get_sockets
    socket = sockets |> hd
    WorldMap.WorldMapChannel.handle_out("updates:set_location", %{current_location: "city_tokyo_orange"}, socket)
  end

  defcast remove_player_location(sockets, old_player), state: state do
    sockets = state.sockets
    socket = sockets |> hd
    WorldMap.WorldMapChannel.handle_out("updates:remove_location", old_player, socket)
    new_state(state)
  end

  defcast set_player_location(sockets, player), state: state do
    sockets = state.sockets
    socket = sockets |> hd
    WorldMap.WorldMapChannel.handle_out("updates:set_location", player, socket)
    new_state(state)
  end

end
