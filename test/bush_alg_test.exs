defmodule BushAlgTest do
  use ExUnit.Case
  doctest BushAlg


  test "bush height" do
    assert BushAlg.height(20) == 20
    assert BushAlg.height({5, 6}) == 7
    assert BushAlg.height({5, {9,10}}) == 12
  end

  describe "concat" do 
    test "it creates a fork for two leaves" do 
      assert BushAlg.concat(1, 2) == {1, 2}
    end    

    test "it creates a fork for a fork and a leaf" do 
      assert BushAlg.concat(1, {2, 3}) == {1, {2, 3}}
    end
  end

  describe "build" do 
    test "it takes a list of bushes and concatonates them" do 
      bushes = [{1,2}, 5, {5, 6}]
      assert BushAlg.build(bushes) == { {{1,2}, 5}, {5, 6} }
    end
  end
end
