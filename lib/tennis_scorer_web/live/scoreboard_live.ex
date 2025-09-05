defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       game: %{
         name_1: "Player one",
         name_2: "Player two",
         score_1: 0,
         score_2: 0
       },
       name_1: "Player one",
       name_2: "Player two",
       edit_player_1?: false,
       edit_player_2?: false
     )}
  end

  @impl LiveView
  def handle_event("edit-player-1", _unsigned_params, socket) do
    {:noreply, assign(socket, edit_player_1?: true)}
  end

  def handle_event("edit-player-2", _unsigned_params, socket) do
    {:noreply, assign(socket, edit_player_2?: true)}
  end

  def handle_event("point-to-player-1", _unsigned_params, socket) do
    {:noreply, update(socket, :game, fn game -> increment_score(game, :score_1) end)}
  end

  def handle_event("point-to-player-2", _unsigned_params, socket) do
    {:noreply, update(socket, :game, fn game -> increment_score(game, :score_2) end)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, update(socket, :game, fn game -> %{game | score_1: 0, score_2: 0} end)}
  end

  def handle_event("submit-player-1", %{"name" => name}, socket) do
    {:noreply,
     socket |> assign(name_1: name, edit_player_1?: false) |> update(:game, fn game -> %{game | name_1: name} end)}
  end

  def handle_event("submit-player-2", %{"name" => name}, socket) do
    {:noreply,
     socket |> assign(name_2: name, edit_player_2?: false) |> update(:game, fn game -> %{game | name_2: name} end)}
  end

  defp increment_score(game, player) do
    Map.update!(game, player, fn score -> score + 1 end)
  end

  attr :input_id, :string, required: true
  attr :value, :string, required: true
  attr :rest, :global

  defp edit_name_form(assigns) do
    ~H"""
    <form {@rest}>
      <.input
        id={@input_id}
        name="name"
        value={@value}
        class="pt-0 text-xl max-w-40 border px-2"
        phx-hook=".AutoFocus"
      />
    </form>
    <script :type={Phoenix.LiveView.ColocatedHook} name=".AutoFocus">
      export default {
        mounted() {
          this.el.focus()
          this.el.select()
        }
      }
    </script>
    """
  end
end
