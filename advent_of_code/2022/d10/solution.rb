def solution_pt1(input)
  input
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def prep_data(data)
  data.lines.map(&:chomp).map do |line|
    line == 'noop' ? 0 : line.split.last.to_i
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end