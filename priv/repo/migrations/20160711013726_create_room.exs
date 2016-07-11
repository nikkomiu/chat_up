defmodule ChatUp.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end
