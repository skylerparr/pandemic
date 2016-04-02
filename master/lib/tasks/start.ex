defmodule Mix.Tasks.Master.Start do
  use Mix.Task

  def run(_) do
    IO.puts "starting the master game"

    Master.start

    #receive do
      #  :kill -> fn() -> IO.puts "exiting" end
      #end
  end
  

end
