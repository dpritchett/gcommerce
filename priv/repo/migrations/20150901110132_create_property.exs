defmodule Gcommerce.Repo.Migrations.CreateProperty do
  use Ecto.Migration

  def change do
    create table(:gcommerce_properties) do
      add :name, :string
      add :display_name, :string
    end

    create index(:gcommerce_properties, [:name])
  end
end
