defmodule Login.PageController do
  use Login.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, %{"name" => name}) do
    hash = :crypto.hash(:sha256, name) |> Base.encode16
    master_node = ServerUtil.get_remote_node(Node.list, "master")
    IO.inspect :rpc.call(master_node, PlayerServer, :create_player, [name, hash])

    atlanta_node = ServerUtil.get_remote_node(Node.list, "atlanta")
    IO.inspect atlanta_node

    redirect_url = :rpc.call(atlanta_node, ServerUtil, :get_server, [])
    redirect conn, external: "#{redirect_url}?secret=#{hash}"
  end
end
