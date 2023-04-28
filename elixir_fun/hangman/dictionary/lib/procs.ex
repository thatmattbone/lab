defmodule Procs do

  def hello(greeting) do
    receive do
      msg ->
        IO.puts("#{greeting} #{msg}")
    end
    hello(greeting)
  end

end
