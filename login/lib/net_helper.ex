defmodule NetHelper do

  def get_ip_address do
    {:ok, ifs} = :inet.getifaddrs
    {a, b, c, d} = get_address_tuple(ifs)
    "#{a}.#{b}.#{c}.#{d}"
  end

  defp get_address_tuple([]), do: {127, 0, 0, 1}
  defp get_address_tuple(interfaces) do
    {name, data} = interfaces |> hd

    if(name == 'eth0' or name == 'en0') do
      extract_address(data)
    else
      get_address_tuple(interfaces |> tl)
    end
  end

  defp extract_address(data) do
    ip = data[:addr]
    cond do
      ip == nil ->
        {127,0,0,1}
      ((Tuple.to_list(ip) |> Enum.count) == 4) ->
        ip
      true -> 
        extract_address(data |> tl)
    end
  end

end
