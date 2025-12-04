require './point'
require './grid'

grid = Grid.new(File.readlines('input.txt').map(&:chomp).map(&:chars))

total_rolls_removed = 0

while true do
  grid_with_removable_rolls_marked = grid.map do |contents, point|
    contents == "@" && grid.count_adjacent_rolls(point) < 4 ? 'x' : contents
  end
  accessible_rolls_count = grid_with_removable_rolls_marked.contents.flatten.count {|contents| contents == 'x' }
  puts "Rolls that can now be removed: #{accessible_rolls_count}"
  total_rolls_removed += accessible_rolls_count
  puts "Total rolls removed: #{total_rolls_removed}"
  if accessible_rolls_count == 0
    break
  end
  grid = grid_with_removable_rolls_marked.map do |contents, point|
    contents == 'x' ? '.' : contents
  end
end






