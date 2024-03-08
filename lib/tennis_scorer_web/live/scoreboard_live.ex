defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}), score: %{player_one: 0, player_two: 0})}
  end

  @impl LiveView
  def handle_event("point-to-player-one", _unsigned_params, socket) do
    {:noreply, update(socket, :score, fn score -> Map.update!(score, :player_one, &(&1 + 1)) end)}
  end

  def handle_event("point-to-player-two", _unsigned_params, socket) do
    {:noreply, update(socket, :score, fn score -> Map.update!(score, :player_two, &(&1 + 1)) end)}
  end

  def handle_event(_event, _unsigned_params, socket), do: {:noreply, socket}

  attr :score, :map, required: true

  def score(assigns) do
    ~H"""
    <div id="score"><%= @score.player_one %> – <%= @score.player_two %></div>
    """
  end
end
