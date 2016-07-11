defmodule ChatUp.Api.MessageController do
  use ChatUp.Web, :controller

  alias ChatUp.Message

  def index(conn, %{"topic_id" => topic_id, "page" => page_param}) do
    messages = Repo.all from m in Message,
      where: m.topic_id == ^topic_id

    render(conn, :index, messages: messages)
  end

  def create(conn, %{"topic_id" => topic_id, "message" => message_params}) do
    changeset = Message.changeset(%Message{}, message_params)

    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", room_path(conn, :show, room))
        |> render(:show, message: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChatUp.Api.ChangesetView, :error, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(room, message_params)

    case Repo.update(changeset) do
      {:ok, message} ->
        conn
        render(conn, :show, message: message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChatUp.Api.ChangesetView, :error, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)

    Repo.delete!(message)

    send_resp(conn, :no_content, "")
  end
end
