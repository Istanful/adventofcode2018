require 'minitest/autorun'
require_relative 'vector'
require_relative 'grid'

class SolutionTest < MiniTest::Test
  def test_solve_input
    input = File.read('input.txt').split("\n").map { |row| Vector.from_string(row) }

    pp solve(input)
    assert false
  end

  def solve(input)
    Grid.new(*input).solve_part_2
  end
end
