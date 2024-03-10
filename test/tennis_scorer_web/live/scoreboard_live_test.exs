defmodule TennisScorerWeb.ScoreboardLiveTest do
  use TennisScorerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  @endpoint TennisScorerWeb.Endpoint

  describe "TennisScorerWeb.ScoreboardLive" do
    test "allows player names to be set", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      change_name_1(view, "Alice")
      assert_name_1(view, "Alice")

      change_name_2(view, "Bob")
      assert_name_2(view, "Bob")
    end

    test "tracks the score as points are scored", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      award_point_to_player_1(view)
      assert_score(view, "1 – 0")
      award_point_to_player_2(view)
      assert_score(view, "1 – 1")
    end

    test "allows the scores to be reset", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      award_point_to_player_1(view)
      award_point_to_player_2(view)
      reset_scores(view)
      assert_score(view, "0 – 0")
    end

    test "ignores form submit events", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      view |> element("form") |> render_submit(%{})
    end
  end

  defp change_name_1(view, name) do
    view |> element("form") |> render_change(%{"_target" => ["name_1"], "name_1" => name})
  end

  defp change_name_2(view, name) do
    view |> element("form") |> render_change(%{"_target" => ["name_2"], "name_2" => name})
  end

  defp award_point_to_player_1(view) do
    view |> element("#point_to_player_1") |> render_click()
  end

  defp award_point_to_player_2(view) do
    view |> element("#point_to_player_2") |> render_click()
  end

  defp reset_scores(view) do
    view |> element("#reset_scores") |> render_click()
  end

  defp assert_name_1(view, name) do
    assert view |> element("#name_1[value='#{name}']") |> has_element?()
  end

  defp assert_name_2(view, name) do
    assert view |> element("#name_2[value='#{name}']") |> has_element?()
  end

  defp assert_score(view, score) do
    assert view |> element("#score", score) |> has_element?()
  end
end
