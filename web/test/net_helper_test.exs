defmodule NetHelperTest do
  use ExUnit.Case

  test "should get the ip address" do
    ip = NetHelper.get_ip_address
    assert "10.3.17.25" == ip
  end

  test "should get localhost as backup" do
    ip = NetHelper.get_ip_address
    assert "127.0.0.1" == ip
  end
end
