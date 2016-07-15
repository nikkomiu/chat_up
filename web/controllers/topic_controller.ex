defmodule ChatUp.TopicController do
  use ChatUp.Web, :controller

  alias ChatUp.Topic

  def new(conn, %{"room_id" => room_id}) do
    room = Repo.get!(ChatUp.Room, room_id)
    changeset =
      room
      |> build_assoc(:topics)
      |> Topic.changeset()

    render(conn, :new, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)

    render(conn, :show, topic: topic)
  end

  def create(conn, %{"topic" => topic_params}) do
    room = Repo.get!(ChatUp.Room, topic_params["room_id"])
    changeset =
      room
      |> build_assoc(:topics)
      |> Topic.changeset(topic_params)

    case Repo.insert(changeset) do
      {:ok, topic} ->
        redirect(conn, to: topic_path(conn, :show, topic))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
