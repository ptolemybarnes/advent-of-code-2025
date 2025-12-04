require './point'
require './grid'

grid = Grid.new(File.readlines('input.txt').map(&:chomp).map(&:chars))

result = grid.map do |contents, point|
  contents == "@" && grid.count_adjacent_rolls(point) < 4 ? 'x' : contents
end

accessible_rolls_count = result.contents.flatten.count {|contents| contents == 'x' }

puts "Result: #{accessible_rolls_count}"
