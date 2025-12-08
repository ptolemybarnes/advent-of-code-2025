lines = File.readlines('./input.txt').map(&:chomp)
blank_line_index = lines.find_index("")


ranges = lines[0...blank_line_index].map do |range_as_string|
  start, finish = range_as_string.split('-').map(&:to_i)
  (start..finish)
end

ingredient_ids = lines[blank_line_index + 1..-1]

fresh_ingredient_ids = ingredient_ids.select do |id|
  ranges.any? { |range| range.cover?(id.to_i) }
end

puts "Result: #{fresh_ingredient_ids.length}"
