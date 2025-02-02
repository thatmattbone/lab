defmodule HeadsUp.Tips do
  def list_tips do
    [
      %{id: 1, text: "This is tip #1."},
      %{id: 2, text: "This is the second tip."},
      %{id: 3, text: "You guessed it, this is my third and final tip."}
    ]
  end

  def lookup_tip(tip_id) when is_integer(tip_id) do
    list_tips() |> Enum.find(fn tip -> tip.id == tip_id end)
  end

  def lookup_tip(tip_id_str) when is_binary(tip_id_str) do
    tip_id = String.to_integer(tip_id_str)

    lookup_tip(tip_id)
  end
end
