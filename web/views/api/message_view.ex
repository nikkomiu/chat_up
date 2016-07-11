defmodule ChatUp.Api.MessageView do
  use ChatUp.Web, :view

  def render("message.json", %{message: message}) do
    %{
      id: message.id,
      body: message.body,
      parent_id: message.parent_id,
      created_at: message.inserted_at,
      updated_at: message.updated_at
    }
  end
end
