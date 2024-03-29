defmodule ChatUp.Api.RoomController do
  use ChatUp.Web, :controller

  alias ChatUp.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render(conn, :index, rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    changeset = Room.changeset(%Room{}, room_params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", room_path(conn, :show, room))
        |> render(:show, room: room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChatUp.Api.ChangesetView, :error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)
    render(conn, :show, room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Repo.get!(Room, id)
    changeset = Room.changeset(room, room_params)

    case Repo.update(changeset) do
      {:ok, room} ->
        render(conn, :show, room: room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChatUp.Api.ChangesetView, :error, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Repo.get!(Room, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(room)

    send_resp(conn, :no_content, "")
  end
end
