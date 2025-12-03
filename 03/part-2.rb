banks = File.readlines('./input.txt').map(&:chomp)

def get_max_of_bank_with_remainder(bank, required_remainder)
  stop_index = -1 - required_remainder
  max = bank[0..stop_index].chars.max
  index = bank[0..stop_index].index(max)
  [max, bank[index+1..-1]]
end

total_number_of_batteries_to_turn_on = 12

result = banks.map do |bank|
  (0..total_number_of_batteries_to_turn_on - 1).to_a.reverse.reduce(['', bank]) do |accum, number_of_batteries_to_turn_on|
    total, remaining_bank = accum
    battery_value, new_remaining_bank = get_max_of_bank_with_remainder(remaining_bank, number_of_batteries_to_turn_on)
    [total + battery_value, new_remaining_bank]
  end.first.to_i
end.sum

puts "Result: #{result}"
