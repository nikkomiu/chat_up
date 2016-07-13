defmodule ChatUp.TopicController do
  use ChatUp.Web, :controller

  alias ChatUp.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{})

    render(conn, :new, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)

    render(conn, :show, topic: topic)
  end

  def create(conn, %{"topic" => topic_params}) do
    changeset = Topic.changeset(%Topic{}, topic_params)

    case Repo.insert(changeset) do
      {:ok, topic} ->
        redirect(conn, to: topic_path(conn, :show, topic))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
