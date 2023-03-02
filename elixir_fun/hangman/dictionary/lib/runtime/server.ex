defmodule Dictionary.Runtime.Server do
  alias Dictionary.Impl.MyDictionary

  @type t :: pid()
  @me __MODULE__
  
  def start_link() do
    Agent.start_link(&MyDictionary.word_list/0, name: @me)
  end

  def random_word() do
    Agent.get(@me, &MyDictionary.random_word/1)
  end
end
