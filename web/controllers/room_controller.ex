defmodule ChatUp.RoomController do
  use ChatUp.Web, :controller

  alias ChatUp.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)

    render(conn, :index, rooms: rooms)
  end

  def show(conn, %{"id" => id}) do
    room = Repo.one!(from r in Room,
      where: r.id == ^id,
      preload: [:topics])

    render(conn, :show, room: room)
  end
end
