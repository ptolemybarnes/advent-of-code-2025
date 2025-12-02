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
  def invalid?
    id_as_string = id.to_s
    id_length = id_as_string.length
    (1..(id_length / 2)).any? do |chunk_length|
      unique_patterns = id_as_string.chars.each_slice(chunk_length).map(&:join).uniq
      unique_patterns.length == 1
    end
  end
end

product_ids = File.read("input.txt").chomp.split(',').map {|id| ProductIDRange.parse(id) }

result = product_ids.flat_map do |product_id_range|
  invalid_ids = product_id_range.select {|product_id| product_id.invalid? }
  invalid_ids
end.map(&:id).sum

puts "Result: #{result}"
