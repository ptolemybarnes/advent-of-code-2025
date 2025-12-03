banks = File.readlines('./input.txt').map(&:chomp)

def get_max_of_bank_with_remainder(bank, required_remainder)
  stop_index = -1 - required_remainder
  max = bank[0..stop_index].chars.max
  index = bank[0..stop_index].index(max)
  [max, bank[index+1..-1]]
end

result = banks.map do |bank|
  first_battery_value, remaining_bank = get_max_of_bank_with_remainder(bank, 1)
  second_battery_value, _ = get_max_of_bank_with_remainder(remaining_bank, 0)
  (first_battery_value + second_battery_value).to_i
end.sum

puts result
raise "#{result} does not equal 17095" unless result === 17095


