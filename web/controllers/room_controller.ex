defmodule ChatUp.RoomController do
  use ChatUp.Web, :controller

  alias ChatUp.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)

    render(conn, :index, rooms: rooms)
  end

  def new(conn, _params) do
    changeset = Room.changeset(%Room{})

    render(conn, :new, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    room = Repo.one!(from r in Room,
      where: r.id == ^id,
      preload: [:topics])

    render(conn, :show, room: room)
  end

  def edit(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    changeset = Room.changeset(room)

    render(conn, :edit, room: room, changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        redirect(conn, to: room_path(conn, :show, room))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Repo.get!(Room, id)
    changeset = Room.changeset(room, room_params)

    case Repo.update(changeset) do
      {:ok, room} ->
        redirect(conn, to: room_path(conn, :show, room))
      {:error, changeset} ->
        render(conn, :edit, room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    Repo.delete!(room)

    redirect conn, to: room_path(conn, :index)
  end
end
