defmodule ServerUtilTest do
  use ExUnit.Case

  test "should node from name" do
    nodes = test_nodes
    assert :"city_seoul_orange@127.0.0.1" == ServerUtil.get_remote_node(nodes, "city_seoul_orange")
  end

  def test_nodes do
    [:"city_osaka_blue@127.0.0.1", :"city_lagos_yellow@127.0.0.1",
      :"city_johanesberg_yellow@127.0.0.1", :"city_stpetersburg_blue@127.0.0.1",
      :"city_toronto_blue@127.0.0.1", :"city_saopaolo_yellow@127.0.0.1",
      :"city_milan_blue@127.0.0.1", :"city_washington_blue@127.0.0.1",
      :"city_manila_orange@127.0.0.1", :"city_london_blue@127.0.0.1",
      :"city_tokyo_orange@127.0.0.1", :"city_beijing_orange@127.0.0.1",
        :"city_chicago_blue@127.0.0.1", :"city_paris_blue@127.0.0.1",
         :"city_taipei_orange@127.0.0.1", :"city_hongkong_orange@127.0.0.1",
          :"city_madrid_blue@127.0.0.1", :"city_lima_yellow@127.0.0.1",
           :"city_newyork_blue@127.0.0.1", :"city_algierso_black@127.0.0.1",
            :"city_santiago_yellow@127.0.0.1", :"city_baghdad_black@127.0.0.1",
             :"city_tehran_black@127.0.0.1", :"city_seoul_orange@127.0.0.1",
              :"city_mumbai_black@127.0.0.1", :"city_moscow_black@127.0.0.1",
               :"city_shanghai_orange@127.0.0.1", :"city_buenosaires_yellow@127.0.0.1",
                :"city_mexicocity_yellow@127.0.0.1", :"city_khartoum_yellow@127.0.0.1",
                 :"city_chennai_black@127.0.0.1", :"city_losangeles_yellow@127.0.0.1",
                  :"city_kolkata_black@127.0.0.1", :"city_bogota_yellow@127.0.0.1",
                   :"city_miami_yellow@127.0.0.1", :"city_riyadh_black@127.0.0.1",
                    :"city_essen_blue@127.0.0.1", :"city_kinshasa_yellow@127.0.0.1",
                     :"city_jakarta_orange@127.0.0.1", :"city_karachi_black@127.0.0.1",
                      :"city_sanfrancisco_blue@127.0.0.1"]  
  end
end
