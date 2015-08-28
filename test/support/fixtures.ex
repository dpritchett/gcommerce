defmodule Gcommerce.Fixtures do
  alias Gcommerce.Fixtures.OptionTypes
  alias Gcommerce.Fixtures.Products
  alias Gcommerce.Fixtures.Variants

  def fixture(:product, attrs) do
    Products.fixture(:product, attrs)
  end

  def fixture(:variant, attrs) do
    Variants.fixture(:variant, attrs)
  end

  def fixture(:option_type, attrs) do
    OptionTypes.fixture(:option_type, attrs)
  end

end
