defmodule MyLists do

  def len([]) do
    0
  end

  def len([_first | rest]) do
    1 + len(rest)
  end

  def sum([]) do
    0
  end

  def sum([first | rest]) do
    first + sum(rest)
  end

  def square_list([]) do
    []
  end

  def square_list([first | rest]) do
    [first**2 | square_list(rest)]
  end
end
