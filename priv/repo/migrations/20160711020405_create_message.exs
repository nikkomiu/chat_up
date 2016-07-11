defmodule ChatUp.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :topic_id, references(:topics, on_delete: :delete_all)
      add :parent_id, references(:messages, on_delete: :delete_all)

      timestamps()
    end

    create index(:messages, [:topic_id])
    create index(:messages, [:parent_id])
  end
end
