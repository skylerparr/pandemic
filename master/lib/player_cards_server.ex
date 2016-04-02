defmodule PlayerCardsServer do
  use ExActor.GenServer, export: :player_cards_server

  defstart start_link(cities), do: initial_state(%{available: cities, discard: []})

  defcall draw_top_card, state: state do
    available = Map.get(state, :available)
    city = available |> hd
    state = Map.put(state, :available, available |> tl)
    set_and_reply(state, city)
  end

  defcast discard_card(city), state: state do
    discard = Map.get(state, :discard)
    discard = [city | discard]
    state = Map.put(state, :discard, discard)
    set_and_reply(state, city)
  end

  defcall get_available, state: state, do: Map.get(state, :available) |> reply
  defcall get_discarded, state: state, do: Map.get(state, :discard) |> reply

  defcast reset(cities), state: state, do: new_state(%{available: cities, discard: []})
end
