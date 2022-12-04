defmodule Day02 do

  # A for Rock, B for Paper, and C for Scissors
  # X for Rock, Y for Paper, and Z for Scissors
  def decode(x) when x == "A", do: :rock
  def decode(x) when x == "X", do: :rock
  def decode(x) when x == "B", do: :paper
  def decode(x) when x == "Y", do: :paper
  def decode(x) when x == "C", do: :scissors
  def decode(x) when x == "Z", do: :scissors

  # 1 for Rock, 2 for Paper, and 3 for Scissors
  def score_move(x) when x == :rock, do: 1
  def score_move(x) when x == :paper, do: 2
  def score_move(x) when x == :scissors, do: 3

  # them, me
  def game_result(x, y) when x == :rock and y == :rock, do: :draw
  def game_result(x, y) when x == :paper and y == :paper, do: :draw
  def game_result(x, y) when x == :scissors and y == :scissors, do: :draw

  def game_result(x, y) when x == :rock and y == :paper, do: :win
  def game_result(x, y) when x == :rock and y == :scissors, do: :lose

  def game_result(x, y) when x == :paper and y == :rock, do: :lose
  def game_result(x, y) when x == :paper and y == :scissors, do: :win

  def game_result(x, y) when x == :scissors and y == :rock, do: :win
  def game_result(x, y) when x == :scissors and y == :paper, do: :lose


  # 0 if you lost, 3 if the round was a draw, and 6 if you won
  def score_game(result, _their_move, my_move) when result == :win do
    6 + score_move(my_move)
  end

  def score_game(result, _their_move, my_move) when result == :lose do
    score_move(my_move)
  end

  def score_game(result, _their_move, my_move) when result == :draw do
    3 + score_move(my_move)
  end

  def part1_example() do
    their_move = decode("A")
    my_move = decode("Y")
    one = score_game(game_result(their_move, my_move), their_move, my_move)

    their_move = decode("B")
    my_move = decode("X")
    two = score_game(game_result(their_move, my_move), their_move, my_move)

    their_move = decode("C")
    my_move = decode("Z")
    three = score_game(game_result(their_move, my_move), their_move, my_move)

    one + two + three
  end

  def part1() do
    games = File.read!("input/input_02")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " "))

    Enum.map(games, fn [their_move, my_move] ->
      their_move_decoded = decode(their_move)
      my_move_decoded = decode(my_move)

      result = game_result(their_move_decoded, my_move_decoded)

      score_game(result, their_move_decoded, my_move_decoded)
    end) |> Enum.sum()
  end

  # X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win.
  def need_to(x) when x == "X", do: :lose
  def need_to(x) when x == "Y", do: :draw
  def need_to(x) when x == "Z", do: :win

  def calc_move(result, their_move) when result == :draw, do: their_move
  def calc_move(result, their_move) when result == :win and their_move == :rock, do: :paper
  def calc_move(result, their_move) when result == :win and their_move == :paper, do: :scissors
  def calc_move(result, their_move) when result == :win and their_move == :scissors, do: :rock
  def calc_move(result, their_move) when result == :lose and their_move == :rock, do: :scissors
  def calc_move(result, their_move) when result == :lose and their_move == :paper, do: :rock
  def calc_move(result, their_move) when result == :lose and their_move == :scissors, do: :paper


  def part2_example() do
    their_move = decode("A")
    intended_result = need_to("Y")
    one = score_game(intended_result, their_move, calc_move(intended_result, their_move))

    their_move = decode("B")
    intended_result = need_to("X")
    two = score_game(intended_result, their_move, calc_move(intended_result, their_move))

    their_move = decode("C")
    intended_result = need_to("Z")
    three = score_game(intended_result, their_move, calc_move(intended_result, their_move))

    one + two + three
  end

  def part2() do
    games = File.read!("input/input_02")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " "))

    Enum.map(games, fn [their_move, expected_result] ->
      their_move_decoded = decode(their_move)
      intended_result = need_to(expected_result)

      my_move = calc_move(intended_result, their_move_decoded)

      score_game(intended_result, their_move_decoded, my_move)
    end) |> Enum.sum()
  end

end
