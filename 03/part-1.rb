banks = File.readlines('./input.txt').map(&:chomp)

result = banks.map do |bank|
  first_battery_value = bank[0..-2].chars.max
  index_of_first_battery_value = bank[..-2].index(first_battery_value)
  second_battery_value = bank[index_of_first_battery_value+1..-1].chars.max
  (first_battery_value + second_battery_value).to_i
end.sum

puts result


