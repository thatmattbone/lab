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

  test "new game returns only a list of lower case letters" do
    game = Game.new_game()

    game.letters
      |> Enum.map(fn (letter) ->
        [letter_int_val] = String.to_charlist(letter)

        assert letter_int_val >= 97  # 'z'
        assert letter_int_val <= 122 # 'z'
      end)
  end

  test "state does not change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("ponies")
      game = Map.put(game, :game_state, state)

      {new_game, _tally} = Game.make_move(game, "a")

      assert new_game == game
    end
  end

end
