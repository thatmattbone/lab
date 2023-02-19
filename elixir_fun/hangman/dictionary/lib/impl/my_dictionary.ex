defmodule Dictionary.Impl.MyDictionary do

  def start do
    "../../assets/words.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split(~r/\n/, trim: true)
  end

  def random_word(word_list) do
    word_list |> Enum.random()
  end

end
