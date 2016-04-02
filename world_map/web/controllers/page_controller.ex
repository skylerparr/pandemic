defmodule WorldMap.PageController do
  use WorldMap.Web, :controller

  def index(conn, _params) do
    cities = :rpc.call(:"#{System.get_env("MASTER")}", CityServer, :get_all, [])
    render conn, "index.html", cities: cities
  end

end
