defmodule ServerUtil do
  use ExActor.GenServer, export: :server_util

  defstart start_link, do: initial_state(%{})

  defcast set_hostname(hostname), state: state, do: new_state(Map.put(state, "hostname", hostname))
  defcast set_city(city), state: state, do: new_state(Map.put(state, "city", city))

  defcall get_hostname, state: state, do: reply(Map.get(state, "hostname"))
  defcall get_city, state: state, do: reply(Map.get(state, "city"))

  def update_player_location(secret, city) do
    :rpc.call(:"#{System.get_env("MASTER")}", PlayerServer, :set_current_city, [secret, city])
  end

  def get_server do
    System.get_env("SERVER")
  end

  def get_remote_node(list, query) do
    {:ok, reg} = Regex.compile("#{query}*.")
    search_remote_node(list, reg) 
  end

  defp search_remote_node([], _), do: nil
  defp search_remote_node(list, reg) do
    node = list |> hd
    if (Regex.match?(reg, node |> Atom.to_string)) do
      node 
    else
      search_remote_node(list |> tl, reg)
    end
  end
end
