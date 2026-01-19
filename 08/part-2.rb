require 'benchmark' 

class JunctionBox
  attr_accessor :connections

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
    @connections = []
  end

  def distance_to(other)
    Math.sqrt(((x - other.x) ** 2) + ((y - other.y) ** 2) + ((z - other.z) **2))
  end

  def connect(other)
    if @connections.include? other
      return self
    end
    if self == other
      return self
    end
    @connections << other
    other.connect(self)
    self
  end

  def inspect
    "<Box x={#{x}} y={#{y}} z={#{z}} connections_count={#{@connections.count}}>"
  end
  
  def get_boxes_in_circuit(connections_to_exclude)
    connections_to_exclude.add(self)
    connections_connections = (Set.new(@connections) - connections_to_exclude).map do |connection|
      connection.get_boxes_in_circuit(connections_to_exclude)
    end
    [self, *connections_connections.flatten].uniq
  end

  def connected?(other)
    @connections.include?(other)
  end

  attr_reader :x, :y, :z
end

def get_closest_pair_that_are_not_connected(pairs)
  result = pairs.find do |pair|
    a, b = pair
    !(a == b || a.connected?(b))
  end
  puts "Closest pair is at index #{pairs.index(result)}/#{pairs.count}"
  result
end

def _are_all_boxes_connected?(boxes)
  count_of_boxes_in_circuit = boxes.first.get_boxes_in_circuit(Set.new).size
  puts "Boxes in circuit: #{count_of_boxes_in_circuit}"
  count_of_boxes_in_circuit == boxes.size
end

def are_all_boxes_connected?(boxes)
  result = nil
  time = Benchmark.measure do
    result = _are_all_boxes_connected?(boxes)
  end
  puts "Method call time: #{time}"
  return result
end

boxes = File.readlines("./input.txt").map do |line|
  JunctionBox.new(*line.split(',').map(&:to_i))
end

box_pairs_sorted_by_distance = boxes.product(boxes).sort_by do |pair|
  a, b = pair
  a.distance_to(b)
end

i = 0
until are_all_boxes_connected?(boxes)
  puts "Iteration: #{i}"
  i = i.next
  box_a, box_b = get_closest_pair_that_are_not_connected(box_pairs_sorted_by_distance)
  puts "Connecting boxes #{box_a.inspect} to #{box_b.inspect}"
  last = box_a.connect(box_b)
  puts "Last: #{box_a.x * box_b.x}"
end

