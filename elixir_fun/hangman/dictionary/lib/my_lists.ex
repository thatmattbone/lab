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

  def map([], func) do
    []
  end

  def map([first | rest], func) do
    [func.(first) | map(rest, func)]
  end

  def sum_pairs([]) do
    []
  end

  def sum_pairs([a, b | rest]) do
    [a + b | sum_pairs(rest)]
  end


  def even_len([a | []]) do
    false
  end

  def even_len([a, b | []]) do
    true
  end

  def even_len([a, b | rest]) do
    even_len(rest)
  end
end
