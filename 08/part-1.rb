class JunctionBoxPosition < Struct.new(:x, :y, :z)

  def distance_to(other)
    (x - other.x).abs + (y - other.y).abs + (z - other.z).abs
  end
end

boxes = File.readlines("./test-input.txt").map do |line|
  JunctionBoxPosition.new(*line.split(',').map(&:to_i))
end

position_a = boxes[0]
position_b = boxes[1]

p position_a.distance_to(position_b)
