defmodule Dictionary do
  defdelegate start, to: Dictionary.Impl.MyDictionary
  defdelegate random_word(worl_list), to: Dictionary.Impl.MyDictionary
end
