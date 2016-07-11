defmodule ChatUp.Topic do
  use ChatUp.Web, :model

  schema "topics" do
    field :name, :string
    field :audience, :integer
    belongs_to :room, ChatUp.Room

    has_many :messages, ChatUp.Message

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :audience])
    |> validate_required([:name, :audience])
  end
end
