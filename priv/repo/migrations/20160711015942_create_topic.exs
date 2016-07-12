defmodule ChatUp.Repo.Migrations.CreateTopic do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string, null: false
      add :audience, :integer
      add :room_id, references(:topics, on_delete: :delete_all)

      timestamps()
    end

    create index(:topics, [:room_id])
    create index(:topics, [:name, :room_id], unique: true)
  end
end
