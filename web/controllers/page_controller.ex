defmodule ChatUp.PageController do
  use ChatUp.Web, :controller

  def index(conn, _params) do
    conn
    |> render :index
  end
end
