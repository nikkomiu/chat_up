defmodule ChatUp.Message do
  use ChatUp.Web, :model

  schema "messages" do
    field :body, :string
    belongs_to :topic, ChatUp.Topic
    belongs_to :parent, ChatUp.Message

    has_many :children, ChatUp.Message

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :parent_id])
    |> validate_required([:body])
  end
end
