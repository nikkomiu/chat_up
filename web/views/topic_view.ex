defmodule ChatUp.TopicView do
  use ChatUp.Web, :view

  def render("index.json", %{topics: topics}) do
    %{data: render_many(topics, ChatUp.TopicView, "topic.json")}
  end

  def render("show.json", %{topic: topic}) do
    %{data: render_one(topic, ChatUp.TopicView, "topic.json")}
  end

  def render("topic.json", %{topic: topic}) do
    %{id: topic.id,
      name: topic.name,
      audience: topic.audience}
  end
end
