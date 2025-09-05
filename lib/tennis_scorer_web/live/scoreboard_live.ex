defmodule TennisScorerWeb.ScoreboardLive do
  @moduledoc false
  use TennisScorerWeb, :live_view

  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       name_1: "Player one",
       name_2: "Player two",
       score_1: 0,
       score_2: 0,
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
    {:noreply, update(socket, :score_1, fn score -> score + 1 end)}
  end

  def handle_event("point-to-player-2", _unsigned_params, socket) do
    {:noreply, update(socket, :score_2, fn score -> score + 1 end)}
  end

  def handle_event("reset-scores", _unsigned_params, socket) do
    {:noreply, assign(socket, score_1: 0, score_2: 0)}
  end

  def handle_event("submit-player-1", %{"name" => name}, socket) do
    {:noreply, assign(socket, name_1: name, edit_player_1?: false)}
  end

  def handle_event("submit-player-2", %{"name" => name}, socket) do
    {:noreply, assign(socket, name_2: name, edit_player_2?: false)}
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
