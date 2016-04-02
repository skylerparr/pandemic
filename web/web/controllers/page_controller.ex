defmodule Web.PageController do
  use Web.Web, :controller

  def index(conn, %{"secret" => secret}) do
    city = ServerUtil.get_city
    ServerUtil.update_player_location(secret, city)
    connections = city["connections"] |> retrieve_connections
    render conn, "index.html", %{disease_count: DiseaseServer.get_count, 
      city: city["name"], connections: connections, secret: secret}
  end

  defp retrieve_connections(connections) do
    list = for connection <- connections do
      IO.inspect connection
      node = ServerUtil.get_remote_node(Node.list, connection["host"])
      IO.inspect node
      server_name = :rpc.call(node, ServerUtil, :get_server, [])
      %{name: connection["name"], server_name: server_name}
    end  
    list
  end
end
