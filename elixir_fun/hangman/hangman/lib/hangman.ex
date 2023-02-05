defmodule Hangman do
  alias Hangman.Impl.Game
  alias Hangman.Type

  @opaque game :: Game.t()


  @spec new_game() :: game
  defdelegate new_game, to: Game

  @spec make_move(game, String.t()) :: {game, Type.tally}
  def make_move(game, guess) do

  end
end
