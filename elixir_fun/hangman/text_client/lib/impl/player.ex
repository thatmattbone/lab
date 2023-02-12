defmodule TextClient.Impl.Player do

  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: {game, tally}


  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("Congrats, you won.")
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost. The word was: #{tally.letters |> Enum.join()}")
  end

  def interact({_game, tally}) do
    IO.puts(feedback_for(tally))

    #interact()
  end

  def feedback_for(tally = %{game_state: :initializing}) do
    "Welcome, I'm thinking of a word with #{tally.letters |> length()} letters."
  end

  def feedback_for(_tally = %{game_state: :good_guess}) do
    "Good guess."
  end

  def feedback_for(_tally = %{game_state: :bad_guess}) do
    "Bad guess."
  end

  def feedback_for(_tally = %{game_state: :already_used}) do
    "That letter was already used."
  end
end
