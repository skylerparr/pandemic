defmodule Master do
  def start do
    Node.start(:"master@#{NetHelper.get_ip_address}")

    PlayerServer.start_link
    
    populate_cities
  end

  def populate_cities do
    {:ok, result} = File.read("#{System.get_env("CITIES")}")
    json = Poison.Parser.parse!(result)

    world = Map.get(json, "world")
    world = map_world(world, %{})

    cities = extract_cities(world)

    CityServer.start_link(world)
    PlayerCardsServer.start_link(cities)
    InfectionCardsServer.start_link(cities)
    GameServer.start_link
  end
  
  def reset_game do
    PlayerServer.reset
    world = CityServer.get_all
    cities = extract_cities(world)
    PlayerCardsServer.reset(cities)
    InfectionCardsServer.reset(cities)
  end

  defp extract_cities(world) do
    cities = for city <- world |> Map.keys do
      Map.get(world, city)
    end
  end
  
  defp map_world([], map), do: map
  defp map_world(world, map) do
    head = world |> hd
    key = Map.keys(head) |> hd
    map = Map.put(map, key, Map.get(head, key))
    map_world(world |> tl, map)
  end
end
