defmodule KVServer.Command do
  @doc ~S"""
  Parses the given `line` into a command.any()

  ## Examples
      iex> KVServer.Command.parse("CREATE shopping\r\n")
      {:ok, {:create, "shopping"}}

  """
  def parse(_line) do
    :not_implemented
  end
end
