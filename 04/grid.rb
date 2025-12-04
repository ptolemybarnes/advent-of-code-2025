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
    Grid.new(contents.map.with_index do |line, y|
      line.map.with_index do |contents, x|
        yield contents, Point.new(x, y)
      end
    end)
  end
end
