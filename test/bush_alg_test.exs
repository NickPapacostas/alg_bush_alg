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
      assert BushAlg.build(bushes) == {{{1, 2}, 5}, {5, 6}}
    end

    test "more bushes" do 
      bushes = [10, {5, {6,8}}, {1,2}, 5, {5, 6}]
      assert BushAlg.build(bushes) ==  {{5, {5, 6}}, {{{1, 2}, {5, {6, 8}}}, {5, {6, 8}}}}
    end

    test "builds optimal height bushes" do 
      example = [4,2,3,5,1,4,6]      
      assert BushAlg.height( BushAlg.build(example)) == 7
    end
  end

  describe "build merge" do 
    test "simple example" do 
      bushes = [10, 5]
      assert BushAlg.build_merge(bushes) == {10, 5}
    end

    test "another simple example" do 
      bushes = [10, {6, 3}]
      assert BushAlg.build_merge(bushes) == {10, {6, 3}}
    end
    
    test "another another simple example" do 
      bushes = [10, {6, 3}, 12, {4, 3}]
      assert BushAlg.build_merge(bushes) == { {10, {6, 3}}, {12, {4, 3}}}
    end
  end

  test "ubertester" do 
    all = for z <- 0..1000 do 
      rands = for y <- 0..Enum.random(10..5), do: Enum.random(0..20)
      {length(rands), BushAlg.height(BushAlg.build(rands)), BushAlg.height(BushAlg.build_merge(rands))} 
    end |> List.keysort(0)

    build_better = Enum.filter(all, fn({len, b, bm}) -> b < bm end) 
    length(build_better)

    build_merge_better = Enum.filter(all, fn({len, b, bm}) -> b > bm end) 
    length(build_merge_better)

    equal = Enum.filter(all, fn({len, b, bm}) -> b == bm end) 
    length(equal)

  end
end
