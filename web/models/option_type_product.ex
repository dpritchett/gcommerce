defmodule Gcommerce.OptionTypeProduct do
  use Gcommerce.Web, :model

  schema "gcommerce_option_type_products" do
    belongs_to :product, Gcommerce.Product
    belongs_to :option_type, Gcommerce.OptionType
  end

  @required_fields ~w(option_type_id product_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, ~w())
    |> foreign_key_constraint(:option_type_id)
    |> foreign_key_constraint(:product_id)
  end
end
