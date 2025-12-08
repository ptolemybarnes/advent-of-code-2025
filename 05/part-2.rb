class Start < Struct.new(:value)
  def start?
    true
  end
end

class Finish < Struct.new(:value)
  def start?
    false
  end
end

lines = File.readlines('./input.txt').map(&:chomp)
blank_line_index = lines.find_index("")

markers = lines[0...blank_line_index].flat_map do |range_as_string|
  start, finish = range_as_string.split('-').map(&:to_i)
  [Start.new(start), Finish.new(finish)]
end

sorted_markers = markers.sort do |first, second|
  if first.value > second.value
    1
  elsif first.value == second.value
    if first.start? # start should come before finish when they are the same.
      -1
    else
      1
    end
  else
    -1
  end
end

stack = []
simplified_markers = []

sorted_markers.each do |marker, index|
  if marker.start?
    if stack.empty? # empty stack means a start marks beginning of a range.
      simplified_markers.push(marker)
    end
    stack.push(marker)
  else
    if stack.length == 1 # stack has only 1 start, so finish marks end of a range.
      simplified_markers.push(marker)
    end
    stack.pop
  end
end

range_sizes = simplified_markers.each_slice(2).map do |markers|
  start, finish = markers
  (finish.value - start.value) + 1 # add one as range is inclusive
end

# 343329651880509
puts "Result: #{range_sizes.sum}"
