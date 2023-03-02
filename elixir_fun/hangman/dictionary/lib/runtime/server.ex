defmodule Dictionary.Runtime.Server do
  alias Dictionary.Impl.MyDictionary

  def start_link() do
    Agent.start_link(&MyDictionary.word_list/0)
  end

  def random_word(pid) do
    Agent.get(pid, &MyDictionary.random_word/1)
  end
end
