defmodule LineSegment do
  def make(p1, p2), do: [p1 | p2]
  def start_of(s), do: hd s
  def end_of(s), do: tl s

  def midpoint(s) do
    x = (Point.x(start_of(s)) + Point.x(end_of(s))) / 2
    y = (Point.y(start_of(s)) + Point.y(end_of(s))) / 2
    Point.make x, y
  end
end

defmodule Point do
  def make(x, y), do: [x | y]
  def x(p), do: hd p
  def y(p), do: tl p
end

ExUnit.start

defmodule MidpointTest do
  use ExUnit.Case, async: true

  test "it computes midpoints" do
    p1 = Point.make 0, 0
    p2 = Point.make 10, 10
    segment = LineSegment.make p1, p2
    assert LineSegment.midpoint(segment) == Point.make(5, 5)
  end
end
