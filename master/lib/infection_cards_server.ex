defmodule InfectionCardsServer do
  use ExActor.GenServer, export: :infection_cards_server

  defstart start_link(cities), do: initial_state(%{available: cities, discard: []})

  defcall draw_top_card, state: state do
    available = Map.get(state, :available)
    discard = Map.get(state, :discard)

    city = available |> hd
    discard = [city | discard]

    state = Map.put(state, :discard, discard)
    state = Map.put(state, :available, available |> tl)

    set_and_reply(state, city)
  end

  defcall draw_bottom_card, state: state do
    available = Map.get(state, :available)
    discard = Map.get(state, :discard)

    city = available |> List.last
    discard = [city | discard]

    state = Map.put(state, :discard, discard)
    state = Map.put(state, :available, available |> List.delete(city))

    set_and_reply(state, city)
  end

  defcast shuffle_and_return_discard, state: state do
    available = Map.get(state, :available)
    discard = Map.get(state, :discard)

    discard = discard |> Enum.shuffle
    available = [discard | available]

    state = Map.put(state, :discard, %{})
    state = Map.put(state, :available, available)

    new_state(state)
  end

  defcall get_available, state: state, do: Map.get(state, :available) |> reply
  defcall get_discarded, state: state, do: Map.get(state, :discard) |> reply

  defcast reset(cities), state: state, do: %{available: cities, discard: []} |> new_state
end
