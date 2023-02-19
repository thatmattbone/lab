defmodule Procs do

  def hello() do
    receive do
      msg ->
        IO.puts("Hello #{msg}")
    end
    hello()
  end

end
