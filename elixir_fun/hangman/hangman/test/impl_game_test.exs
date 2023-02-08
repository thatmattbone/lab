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

  test "a duplicate letter is reported" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game()

    {game, _tally} = Game.make_move(game, "x")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "x")

    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end

  test "we recognize a letter in the word" do
    game = Game.new_game("ponies")

    {game, tally} = Game.make_move(game, "n")
    assert tally.game_state == :good_guess

    {game, tally} = Game.make_move(game, "o")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter that is not in the word" do
    game = Game.new_game("ponies")

    {game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess

    {game, tally} = Game.make_move(game, "o")
    assert tally.game_state == :good_guess
  end

  test "can handle a sequence of moves" do
    word = "hello"
    test_sequence = [
      ["a", :bad_guess,     6, ["_", "_", "_", "_", "_"], ["a"]],
      ["a", :already_used,  6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess,    6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess,     5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]],
    ]

    run_test_sequence(word, test_sequence)
  end

  test "can handle a winning game" do
    word = "hello"
    test_sequence = [
      ["a", :bad_guess,    6, ["_", "_", "_", "_", "_"], ["a"]],
      ["a", :already_used, 6, ["_", "_", "_", "_", "_"], ["a"]],
      ["e", :good_guess,   6, ["_", "e", "_", "_", "_"], ["a", "e"]],
      ["x", :bad_guess,    5, ["_", "e", "_", "_", "_"], ["a", "e", "x"]],
      ["l", :good_guess,   5, ["_", "e", "l", "l", "_"], ["a", "e", "l", "x"]],
      ["o", :good_guess,   5, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "x"]],
      ["y", :bad_guess,    4, ["_", "e", "l", "l", "o"], ["a", "e", "l", "o", "x", "y"]],
      ["h", :won,          4, ["h", "e", "l", "l", "o"], ["a", "e", "h", "l", "o", "x", "y"]],
    ]
    run_test_sequence(word, test_sequence)
  end

  def run_test_sequence(word, sequence) do
    game = Game.new_game(word)

    step_test_sequence(game, sequence)
  end

  def step_test_sequence(game, []) do
    game
  end

  def step_test_sequence(game, [[guess, expected_state, expected_turns_left, expected_letters, expected_used] | rest]) do
    {game, tally} = Game.make_move(game, guess)

    assert tally.game_state == expected_state
    assert tally.turns_left == expected_turns_left
    assert tally.letters == expected_letters
    assert tally.used == expected_used

    step_test_sequence(game, rest)
  end

end
