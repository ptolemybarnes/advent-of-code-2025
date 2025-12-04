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

class Grid < Struct.new(:contents)

  def get_at(point)
    return nil if !point.valid?
    if (item = contents[point.y] && contents[point.y][point.x])
      return item
    end
    return nil
  end

  def get_adjacent(point)
    [
      point.north,
      point.north_east,
      point.east,
      point.south_east,
      point.south,
      point.south_west,
      point.west,
      point.north_west
    ].map {|adjacent_point| get_at(adjacent_point) }.compact
  end

  def count_adjacent_rolls(point)
    get_adjacent(point).count {|contents| contents == "@"}
  end

  def map
    contents.map.with_index do |line, y|
      line.map.with_index do |contents, x|
        yield contents, Point.new(x, y)
      end
    end
  end
end

grid = Grid.new(File.readlines('input.txt').map(&:chomp).map(&:chars))

result = grid.map do |contents, point|
  contents == "@" && grid.count_adjacent_rolls(point) < 4 ? 'x' : contents
end

accessible_rolls_count = result.flatten.count {|contents| contents == 'x' }

puts "Result: #{accessible_rolls_count}"





