defmodule DiseaseServer do
  use ExActor.GenServer, export: :__MODULE__

  defstart start_link, do: initial_state(0)

  defcast inc, state: state do
    if state == 3 do
      new_state(3)
    else
      new_state(state + 1)
    end
  end

  defcast dec, state: state do 
    if state == 0 do
      new_state(0)
    else
      new_state(state - 1)
    end
  end

  defcall get_count, state: state, do: reply(state)

  defcast stop, do: stop_server(:normal)

end
