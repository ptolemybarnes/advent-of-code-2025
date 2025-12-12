lines = File.readlines('input.txt').map(&:chomp)

numbers = lines[0..-2]
operations = lines.last

transformed_numbers = operations.length.times.map do |idx|
  numbers.map do |number_line|
    number_line[idx]
  end.map(&:strip).reject(&:empty?).join
end.slice_when {|element| element.empty? }.to_a

result = operations.split(/\s+/).map.with_index do |operation, index|
  transformed_numbers[index]
    .reject(&:empty?)
    .map(&:to_i)
    .reduce(operation.to_sym)
end.sum

puts "Result: #{result}"
