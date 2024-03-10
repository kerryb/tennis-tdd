defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(game: %{name_1: "Player one", name_2: "Player two", score_1: 0, score_2: 0})
     |> build_form()}
  end

  @impl LiveView
  def handle_event("point-to-player-1", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &award_point_to_player_1/1)}
  end

  def handle_event("point-to-player-2", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &award_point_to_player_2/1)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &reset_scores/1)}
  end

  def handle_event("change", %{"_target" => ["name_1"], "name_1" => name}, socket) do
    {:noreply, socket |> update(:game, &change_name_1(&1, name)) |> build_form()}
  end

  def handle_event("change", %{"_target" => ["name_2"], "name_2" => name}, socket) do
    {:noreply, socket |> update(:game, &change_name_2(&1, name)) |> build_form()}
  end

  def handle_event(_event, _unsigned_params, socket), do: {:noreply, socket}

  defp build_form(socket) do
    assign(socket,
      form:
        to_form(%{
          "name_1" => socket.assigns.game.name_1,
          "name_2" => socket.assigns.game.name_2
        })
    )
  end

  defp award_point_to_player_1(game), do: Map.update!(game, :score_1, &(&1 + 1))

  defp award_point_to_player_2(game), do: Map.update!(game, :score_2, &(&1 + 1))

  defp reset_scores(game), do: %{game | score_1: 0, score_2: 0}

  defp change_name_1(game, name), do: Map.put(game, :name_1, name)

  defp change_name_2(game, name), do: Map.put(game, :name_2, name)
end
