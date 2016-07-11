defmodule ChatUp.RoomView do
  use ChatUp.Web, :view

  def render("index.json", %{rooms: rooms}) do
    render_many(rooms, ChatUp.RoomView, "room.json")
  end

  def render("show.json", %{room: room}) do
    render_one(room, ChatUp.RoomView, "room.json")
  end

  def render("room.json", %{room: room}) do
    %{id: room.id,
      name: room.name,
      description: room.description}
  end
end
