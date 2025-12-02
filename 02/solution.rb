

class ProductIDRange
  include Enumerable

  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def each
    (start..finish).each do |n|
      product_id = ProductID.new(n)
      yield product_id
    end
  end

  def self.parse(text)
    start, finish = text.split('-')
    new(start.to_i, finish.to_i)
  end

  def to_s
    "<ProductIDRange (#{start}..#{finish}) >"
  end
end

class ProductID < Struct.new(:id)
  def valid?
    id_as_string = id.to_s
    id_length = id_as_string.length
    if id_length.odd?
      return true
    end
    index_of_middle = (id_length / 2) - 1
    first_half = id_as_string[0..index_of_middle]
    second_half = id_as_string[index_of_middle.next..-1]
    return first_half != second_half
  end
end

product_ids = File.read("input.txt").chomp.split(',').map {|id| ProductIDRange.parse(id) }

result = product_ids.flat_map do |product_id_range|
  invalid_ids = product_id_range.reject {|product_id| product_id.valid? }
  # puts "#{product_id_range} has the invalid IDs: #{invalid_ids.map(&:id).map(&:to_s).join(', ')}"
  invalid_ids
end.map(&:id).sum

puts "Result: #{result}"
