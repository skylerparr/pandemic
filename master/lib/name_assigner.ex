defmodule NameAssigner do
  def get_name do
    all_nodes = Node.list
    all_cities = CityServer.get_all

    name = find_unassigned_name(all_nodes, Map.keys(all_cities))
    Map.get(all_cities, name)
  end

  def find_unassigned_name(nodes, cities) do
    city = cities |> hd
    {:ok, reg} = Regex.compile(".*#{city}.*")
    if(node_found?(nodes, reg)) do
      find_unassigned_name(nodes, cities |> tl)
    else
      city
    end
  end

  def node_found?([], _), do: false
  def node_found?(nodes, reg) do
    node = nodes |> hd
    if(Regex.match?(reg, node |> Atom.to_string)) do
      true
    else
      node_found?(nodes |> tl, reg)
    end
  end
end
