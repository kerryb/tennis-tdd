defmodule TennisScorer.GameTest do
  use ExUnit.Case, async: true

  alias TennisScorer.Game

  describe "TennisScorer.Game.new/2" do
    test "initialises both scores to zero" do
      assert %{name_1: "Alice", name_2: "Bob", score_1: 0, score_2: 0} = Game.new("Alice", "Bob")
    end
  end
end
