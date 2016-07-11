defmodule ChatUp.Room do
  use ChatUp.Web, :model

  schema "rooms" do
    field :name, :string
    field :description, :string

    has_many :topics, ChatUp.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name])
  end
end
