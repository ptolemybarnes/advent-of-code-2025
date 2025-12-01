class Dial
  attr_reader :current

  def initialize
    @current = 50
  end

  def wind_forwards(n)
    @current = (@current + n) % 100
  end

  def wind_backwards(n)
    @current = (@current - n) % 100
  end

  def zero?
    @current == 0
  end
end

class Rotation
  attr_reader :number_of_clicks

  def initialize(instruction)
    @is_forward = instruction[0] == 'R'
    @number_of_clicks = instruction[1..].to_i
  end

  def forward?
    @is_forward
  end

  def backwards?
    !forward?
  end
end

input = File.readlines('./input.txt')
rotations = input.map {|line| Rotation.new(line) }

dial = Dial.new

zeros_count = rotations.count do |rotation|
  if rotation.forward?
    dial.wind_forwards(rotation.number_of_clicks)
  else 
    dial.wind_backwards(rotation.number_of_clicks)
  end
  dial.zero?
end

puts zeros_count
