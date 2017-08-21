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

  def height([one]), do: one

  @spec build(list(bush)) :: bush
  def build([{left, right}]), do: {left, right}
  def build([first, second, third | []]) do
    [sfirst, ssecond, sthird] = Enum.sort_by([first, second, third], fn(bush) -> BushAlg.height(bush) end)  
    {{sfirst, ssecond}, sthird}
  end
  def build([first, second | bushes]), do: build( bushes ++ [{first, second}] )

  
  def build_merge([first, second]), do: {first, second}
  def build_merge([_first, _second, _third] = list) do 
    [sfirst, ssecond, sthird] = Enum.sort_by(list, fn(bush) -> BushAlg.height(bush) end)  
    {{sfirst, ssecond}, sthird}
  end

  def build_merge(bushes) do 
    case Enum.split(bushes, div(length(bushes), 2)) do
      {[], first} -> first
      {first_half, second_half} ->
        {build_merge(first_half), build_merge(second_half)}
    end
  end
end
