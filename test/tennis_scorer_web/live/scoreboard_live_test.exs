defmodule TennisScorerWeb.ScoreboardLiveTest do
  use TennisScorerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  @endpoint TennisScorerWeb.Endpoint

  describe "TennisScorerWeb.ScoreboardLive" do
    test "allows player names to be set", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      change_player_one_name(view, "Alice")
      change_player_two_name(view, "Bob")
      assert_score(view, "Alice 0 – 0 Bob")
    end

    test "tracks the score as points are scored", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      award_point_to_player_one(view)
      assert_score(view, "1 – 0")
      award_point_to_player_two(view)
      assert_score(view, "1 – 1")
    end
  end

  defp change_player_one_name(view, name) do
    view |> element("form") |> render_change(%{"_target" => ["player_one_name"], "player_one_name" => name})
  end

  defp change_player_two_name(view, name) do
    view |> element("form") |> render_change(%{"_target" => ["player_two_name"], "player_two_name" => name})
  end

  defp award_point_to_player_one(view) do
    view |> element("#point_to_player_one") |> render_click()
  end

  defp award_point_to_player_two(view) do
    view |> element("#point_to_player_two") |> render_click()
  end

  defp assert_score(view, score) do
    assert view |> element("#score", score) |> has_element?()
  end
end
