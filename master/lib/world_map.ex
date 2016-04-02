defmodule WorldMap do

  def update_player(secret) do
    player = PlayerServer.get_player(secret)
    :rpc.call(get_map_node, GameUpdater, :update_player, [player])
  end

  defp get_map_node do
    ServerUtil.get_remote_node(Node.list, "world_map")
  end
end
