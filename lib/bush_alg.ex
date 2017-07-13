defmodule BushAlg do
  @moduledoc """

  """
  @type bush :: leaf | fork
  @type leaf :: integer
  @type fork :: tuple

  @spec height(leaf) :: integer  
  def height(leaf) when is_integer(leaf), do: leaf

  @spec height(fork) :: integer
  def height({left, right}) do 
    Enum.max([height(left), height(right)]) + 1
  end


  @spec concat(bush, bush) :: fork
  def concat(left, right) do 
    {left, right}
  end

  @spec build(list(bush)) :: bush
  def build([single]), do: single
  def build([first, second | bushes]) do
    build([ concat(first, second) | bushes ])
  end

end
