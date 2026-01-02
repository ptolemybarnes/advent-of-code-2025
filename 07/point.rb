class Point < Struct.new(:x, :y)
  def north
    Point.new(x, y - 1)
  end

  def north_east
    Point.new(x + 1, y - 1)
  end

  def east
    Point.new(x + 1, y)
  end

  def south_east
    Point.new(x + 1, y + 1)
  end

  def south
    Point.new(x, y + 1)
  end

  def south_west
    Point.new(x - 1, y + 1)
  end

  def west
    Point.new(x - 1, y)
  end

  def north_west
    Point.new(x - 1, y - 1)
  end

  def valid?
    x >= 0 && y >= 0
  end
end

