defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView
  alias TennisScorer.Game

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(game: Game.new()) |> build_form()}
  end

  @impl LiveView
  def handle_event("point-to-player-1", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.award_point_to_player_1/1)}
  end

  def handle_event("point-to-player-2", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.award_point_to_player_2/1)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, update(socket, :game, &Game.reset_scores/1)}
  end

  def handle_event("change", %{"_target" => ["name_1"], "name_1" => name}, socket) do
    {:noreply, socket |> update(:game, &Game.change_name_1(&1, name)) |> build_form()}
  end

  def handle_event("change", %{"_target" => ["name_2"], "name_2" => name}, socket) do
    {:noreply, socket |> update(:game, &Game.change_name_2(&1, name)) |> build_form()}
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
end
