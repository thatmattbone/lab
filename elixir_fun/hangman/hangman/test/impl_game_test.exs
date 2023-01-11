defmodule HangmanGameImplTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initialized
    assert length(game.letters) > 0
    assert game.used == MapSet.new()
  end


  test "new game returns structure with specified word" do
    game = Game.new_game("ponies")

    assert game.turns_left == 7
    assert game.game_state == :initialized
    assert game.letters == ["p", "o", "n", "i", "e", "s"]
    assert game.used == MapSet.new()
  end

end
