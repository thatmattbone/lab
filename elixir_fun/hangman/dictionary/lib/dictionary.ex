defmodule Dictionary do
  alias Dictionary.Impl.MyDictionary

  @opaque t :: MyDictionary.t()

  @spec start() :: t()
  defdelegate start, to: MyDictionary, as: :word_list

  @spec random_word(t()) :: String.t()
  defdelegate random_word(word_list), to: MyDictionary
end
