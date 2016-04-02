defmodule CityServer do
  use ExActor.GenServer, export: :city_server

  defstart start_link(cities), do: initial_state(cities)

  defcall get_all, state: state, do: reply(state)
  defcall get_city(name), state: state, do: reply(Map.get(state, name))
  defcall get_city_by_host(host), state: state do
    state |> Map.keys |> get_host(state, host) |> reply
  end

  def get_host([], _, _), do: nil
  def get_host(cities, state, host) do
    city_name = cities |> hd
    city = Map.get(state, city_name)
  
    if(city["host"] == host) do
      city
    else 
      get_host(cities |> tl, state, host)
    end
  end

  defcall get_next, state: state do
    key = Map.keys(state) |> hd
    reply(Map.get(state, key))
  end 
end
