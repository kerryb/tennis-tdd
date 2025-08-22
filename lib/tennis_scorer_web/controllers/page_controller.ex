defmodule TennisScorerWeb.PageController do
  use TennisScorerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
