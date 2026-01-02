



class Element
  def empty?
    false
  end
end

class Entrance < Element
  def to_s
    " S "
  end
end

class TychonBeam < Element
  
  def to_s
    " | "
  end
end

class Splitter < Element
  def initialize(activated)
    @activated = activated
  end

  def activated?
    @activated
  end

  def to_s
    activated? ? "/*\\" : "/_\\"
  end
end

class EmptySpace < Element
  def empty?
    true
  end

  def to_s
    ' . '
  end
end

def print_manifold(manifold)
  result = manifold.map do |line|
    (line || []).map(&:to_s).join
  end.join("\n")
  puts result
end

def render_splits(line)
  line.count do |element|
    element.is_a?(Splitter) && element.activated?
  end
  line.map.with_index do |element, index|
    if element.is_a?(Splitter) && element.activated?
      if line[index - 1]
        line[index - 1] = TychonBeam.new
      end
      if line[index.next]
        line[index.next] = TychonBeam.new
      end
    else
      element
    end
  end
end

input = File.readlines('test-input.txt').map(&:chomp)

parsed_manifold = input.map do |line|
  line.split('').map do |element|
    case element
    when "."
      EmptySpace.new
    when "S"
      Entrance.new
    when "^"
      Splitter.new(false)
    end
  end
end

current_line = 0
rendered_manifold = []

def render_next_line_from(line, next_line)
  line.map.with_index do |element, index|
    next_element_down = next_line[index]
    if element.is_a?(Entrance)
      TychonBeam.new
    elsif element.empty?
      next_element_down
    elsif element.is_a? TychonBeam
      if next_element_down.empty?
        TychonBeam.new
      elsif next_element_down.is_a? Splitter
        Splitter.new(true)
      else
        next_element_down
      end
    elsif element.is_a? Splitter
      next_element_down
    end
  end
end

rendered_lines = [parsed_manifold.shift]

until parsed_manifold.empty?
  rendered_line = render_next_line_from(rendered_lines.last, parsed_manifold.shift)
  render_splits(rendered_line)
  rendered_lines.push(rendered_line)
end


print_manifold(rendered_lines)
