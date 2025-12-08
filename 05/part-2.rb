class Start < Struct.new(:value)
  def start?
    true
  end

  def finish?
    false
  end
end

class Finish < Struct.new(:value)
  def start?
    false
  end

  def finish?
    true
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
  if stack.empty? && marker.start?
    stack.push(marker)
    simplified_markers.push(marker)
  elsif marker.start?
    stack.push(marker)
  elsif stack.length == 1 && marker.finish?
    simplified_markers.push(marker)
    stack.pop
  elsif marker.finish?
    stack.pop
  end
end

range_sizes = simplified_markers.each_slice(2).map do |markers|
  start, finish = markers
  (finish.value - start.value) + 1
end

puts "Result: #{range_sizes.sum}"


