defmodule ChatUp.Repo.Migrations.CreateTopic do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string
      add :audience, :integer

      timestamps()
    end

  end
end
