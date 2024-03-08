defmodule TennisScorerWeb.ScoreboardLiveTest do
  use TennisScorerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  @endpoint TennisScorerWeb.Endpoint

  describe "TennisScorerWeb.ScoreboardLive" do
    test "tracks the score as points are scored", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      point_to_player_one(view)
      assert_score(view, "1 – 0")
      point_to_player_two(view)
      assert_score(view, "1 – 1")
    end
  end

  defp point_to_player_one(view) do
    view |> element("#point-to-player-one") |> render_click()
  end

  defp point_to_player_two(view) do
    view |> element("#point-to-player-two") |> render_click()
  end

  defp assert_score(view, score) do
    assert view |> element("#score", score) |> has_element?()
  end
end
