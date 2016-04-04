defmodule Mix.Tasks.Master.Start do
  use Mix.Task

  def run(_) do
    IO.puts "starting the master game"

    Master.start
  end
  

end
