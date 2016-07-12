defmodule ChatUp.TopicChannel do
  use ChatUp.Web, :channel

  def join("topic:" <> topic_id, params, socket) do
    last_seen_id = params["last_seen_id"] || 0

    topic_id = String.to_integer(topic_id)
    topic = Repo.get!(ChatUp.Topic, topic_id)

    messages = Repo.all(
      from a in assoc(topic, :messages),
      where: a.id > ^last_seen_id,
      order_by: [asc: a.inserted_at, asc: a.id],
      limit: 200
    )

    resp = %{messages: Phoenix.View.render_many(messages, ChatUp.Api.MessageView, "message.json")}

    {:ok, resp, assign(socket, :topic_id, topic_id)}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("new_message", params, socket) do
    changeset =
      ChatUp.Message
      |> build_assoc(:messages, topic_id: socket.assigns.topic_id)
      |> ChatUp.Message.changeset(params)

    case Repo.insert(changeset) do
      {:ok, msg} ->
        broadcast_message(socket, msg)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  defp broadcast_message(socket, message) do
    rendered_ann = Phoenix.View.render(ChatUp.Api.MessageView, "message.json", %{
      message: message
    })

    broadcast! socket, "new_annotation", rendered_ann
  end
end
