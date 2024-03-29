defmodule Hangman.Runtime.Server do
  use GenServer
  alias Hangman.Impl.Game

  @type t :: pid()

  ### client process code
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end


  ### server process code
  def init(_) do
    {:ok, Game.new_game()}
  end


  def handle_call({:make_move, guess}, _from, game) do
    {updated_game, tally} = game |> Game.make_move(guess)

    {:reply, tally, updated_game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
