class CyclicalRange
  include Enumerable

  def initialize(start, finish, direction)
    @start = start
    @finish = finish
    @direction = direction
  end

  def self.forwards(start, finish)
    new(start, finish, :forwards)
  end

  def self.backwards(start, finish)
    new(start, finish, :backwards)
  end

  def each
    a = @start
    b = @finish
    if @direction == :forwards
      while a < b
        a += 1
        yield a % 100
      end
    else
      while a > b
        a -= 1
        yield a % 100
      end
    end
  end
end

class Dial
  attr_reader :history

  def initialize(starting)
    @history = starting
  end

  def head
    history.last
  end

  def wind_forwards(n)
    range = CyclicalRange.forwards(head, (head + n))
    Dial.new([*history, *range.to_a])
  end

  def wind_backwards(n)
    range = CyclicalRange.backwards(head, (head - n))
    Dial.new([*history, *range.to_a])
  end

  def to_s
    "<Dial { #{history.join(", ")} }>"
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

  def to_s
    "<Rotation: #{forward? ? 'R' : 'L'} - #{number_of_clicks}>"
  end
end

input = File.readlines('./input.txt')
rotations = input.map(&:rstrip).reject(&:empty?).map {|line| Rotation.new(line) }

final_dial = rotations.reduce(Dial.new([50])) do |dial, rotation|
  if rotation.forward?
    dial.wind_forwards(rotation.number_of_clicks)
  else 
    dial.wind_backwards(rotation.number_of_clicks)
  end
end


puts final_dial.history.count(&:zero?)
