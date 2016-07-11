defmodule ChatUp.TopicView do
  use ChatUp.Web, :view

  def render("show.json", %{topic: topic}) do
    render_one(topic, ChatUp.TopicView, "topic.json")
  end

  def render("topic.json", %{topic: topic}) do
    %{
      id: topic.id,
      name: topic.name,
      audience: topic.audience
    }
  end
end
