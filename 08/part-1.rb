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
    @connections << other
    other.connect(self)
    self
  end

  def inspect
    "<Box x={#{x}} y={#{y}} z={#{z}} connections_count={#{@connections.count}}>"
  end
  
  def get_boxes_in_circuit(connections_to_exclude = [])
    connections_connections = (@connections - connections_to_exclude).map do |connection|
      connection.get_boxes_in_circuit([self, *connections_to_exclude])
    end
    [self, *connections_connections.flatten].uniq
  end

  def connected?(other)
    @connections.include?(other)
  end

  attr_reader :x, :y, :z
end

def get_closest_pair_that_are_not_connected(_boxes)
  _boxes.product(_boxes).min_by do |pair|
    a, b = pair
    if a == b || a.connected?(b)
      Float::INFINITY
    else
      a.distance_to(b)
    end
  end
end

boxes = File.readlines("./input.txt").map do |line|
  JunctionBox.new(*line.split(',').map(&:to_i))
end

1000.times do |i|
  puts "Iteration: #{i}"
  box_a, box_b = get_closest_pair_that_are_not_connected(boxes)
  box_a.connect(box_b)
end

circuits = []
remaining_boxes = boxes.dup

until remaining_boxes.empty? do
  box = remaining_boxes.first
  boxes_in_circuit = box.get_boxes_in_circuit
  circuits << boxes_in_circuit
  remaining_boxes = remaining_boxes - box.get_boxes_in_circuit
end

circuit_sizes = circuits.map(&:size).sort.reverse
puts "Count of circuits: #{circuits.count}"
puts "Circuit sizes: #{circuit_sizes.join(", ")}"

puts "Product of 3 largest circuits: #{circuit_sizes.take(3).reduce(:*)}"


