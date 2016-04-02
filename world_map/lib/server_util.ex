defmodule ServerUtil do
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
