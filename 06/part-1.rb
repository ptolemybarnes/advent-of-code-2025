problems = File.readlines('input.txt').map(&:chomp).map(&:strip).map do |line|
  line.split(/\s+/)
end

results = problems.transpose.map do |problem|
  inputs = problem[0..-2].map(&:to_i)
  operation = problem.last
  case operation
  when "+"
    inputs.sum
  when "*"
    inputs.reduce(&:*)
  end
end

p "Result: #{results.sum}"
