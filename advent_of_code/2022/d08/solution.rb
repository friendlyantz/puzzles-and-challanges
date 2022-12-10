require File.join(__dir__, '../lib/colorize')

include MyColorize

def solution_pt1(input)
  input
    .then { |data| tree(data)}
    .then do |map|
      height = map.matrix.size
      width = map.matrix.first.length
      height.times do |i|
        scan_left(i)
        scan_right(i)
      end

      width.times do |i|
        scan_top(i)
        scan_bottom(i)
      end
      map
    end
    .then { |data| tally_visible(data) }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
end

def tree(data = nil)
  @tree ||= TreeMap.new(data)
end

def tally_visible(data)
  data.matrix.flatten.map { _1[:visible?] }.tally[true]
end

class TreeMap
  attr_reader :matrix

  def initialize(data)
    @matrix = generate_map(data)
  end

  def generate_map(data)
    data.lines.map(&:strip).map do |line|
      line.chars.map do |n|
        {
          value: n.to_i,
          visible?: false,
          scenci_score: 0
        }
      end
    end
  end
end

# def scenic_score(line_num, column_num, tree_map)
#   @tree_map
#     .then do |map|
#       max_height = map.matrix[line_num][column_num][:value]

#       # binding.pry
#       scan_left(tree_map, line_num, max_height, column_num)
#       scan_right(tree_map, line_num, max_height, column_num)
#       # binding.pry
#     end
#     .then { |value| value * 2 }
# end

def scan(line, scan_below = false, max_height)
  stack = []
  max_height ||= hight_of_the_tallest_tree_in_line(line)
  line
    .each_cons(2)
    .with_index do |(prev_cell, next_cell), i|
    if i.eql? 0
      stack << prev_cell[:value] unless scan_below
      prev_cell[:visible?] = true
    end

    if scan_below
      next_cell[:visible?] = true if next_cell[:value] < max_height
    else
      visible_above(next_cell, stack)
    end

    stack << next_cell[:value]
    break if stack.max.eql?(max_height)
  end
  tree_map
end

def visible_above(next_cell, stack)
  next_cell[:visible?] = true if next_cell[:value] > stack.max
end

def scan_top(column_num, max_height = nil, line_num = 0)
  line = tree.matrix.transpose[column_num]
  scan(line, max_height)
end

def scan_bottom(column_num, max_height = nil, line_num = 0)
  line = tree.matrix.transpose[column_num].reverse
  scan(line, max_height)
end

def scan_left(line_num, max_height = nil, start = 0)
  line = tree.matrix[line_num][start..]
  scan(line, max_height)
end

def scan_right(line_num, max_height = nil, column_num = 0)
  line = tree.matrix[line_num].reverse
  scan(line, max_height)
end

def hight_of_the_tallest_tree_in_line(line)
  line.map { _1[:value] }.max
end
if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    raise 'please provide input file destination as an argument following script name when executing this file'
  end

  input = File.read(ARGV.first)
  MyColorize.print_out(
    generate_map(input)
    .map { _1.map { |i| i[:value] } }
  )
  puts 'part 1 solution'
  puts solution_pt1(input)

  puts '==============='
  puts 'part 2 solution'
  puts solution_pt2(input)
end
