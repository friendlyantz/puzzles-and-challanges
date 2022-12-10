require File.join(__dir__, '../lib/colorize')

include MyColorize

def solution_pt1(input)
  input
    .then { |data| TreeMap.new(data) }
    .then do |map|
      height = map.matrix.size
      width = map.matrix.first.length
      height.times do |i|
        scan_left(map, i)
        scan_right(map, i)
      end

      width.times do |i|
        scan_top(map, i)
        scan_bottom(map, i)
      end
      map
    end
    .then { |data| tally_visible(data) }
end

def solution_pt2(input)
  # input
  # .then { |data| binding.pry }
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
          visible?: false
        }
      end
    end
  end
end

def scenic_score(line, column, tree_map)
  tree_map
    .then do |map|
      max_height = map.matrix[line][column][:value]
      scan_visible_trees_left(map, line, column, max_height)
    end
    .then { |value| value * 2 }
end

def scan_visible_trees_left(map, line, column, max_height)
  binding.pry
end

def scan(line, tree_map, _start_coordinate, max_height)
  stack = []
  max_height ||= hight_of_the_tallest_tree_in_line(line)
  line
    .each_cons(2)
    .with_index do |(prev_cell, next_cell), i|
      if i.eql? 0
        stack << prev_cell[:value]
        prev_cell[:visible?] = true
      end

      next_cell[:visible?] = true if next_cell[:value] > stack.max

      stack << next_cell[:value]
      break if stack.max.eql?(max_height)
    end
  tree_map
end

def scan_top(tree_map, column_num, max_height = nil, line_num = 0)
  line = tree_map.matrix.transpose[column_num]
  scan(line, tree_map, line_num, max_height)
end

def scan_bottom(tree_map, column_num, max_height = nil, line_num = 0)
  line = tree_map.matrix.transpose[column_num].reverse
  scan(line, tree_map, line_num, max_height)
end

def scan_left(tree_map, line_num, max_height = nil, column_num = 0)
  line = tree_map.matrix[line_num]
  scan(line, tree_map, column_num, max_height)
end

def scan_right(tree_map, line_num, max_height = nil, column_num = 0)
  line = tree_map.matrix[line_num].reverse
  scan(line, tree_map, column_num, max_height)
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