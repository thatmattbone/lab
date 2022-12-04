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
  def game_result(x, y) when x == :rock and y == :scissor, do: :lose

  def game_result(x, y) when x == :paper and y == :rock, do: :lose
  def game_result(x, y) when x == :paper and y == :scissor, do: :win

  def game_result(x, y) when x == :scissor and y == :rock, do: :win
  def game_result(x, y) when x == :scissor and y == :paper, do: :lose


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
end
