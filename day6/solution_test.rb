require 'minitest/autorun'
require_relative 'vector'
require_relative 'grid'

class SolutionTest < MiniTest::Test
  def test_solve_basic
    # X..o..X
    # ..oOo..
    # X..o..X
    vectors = [
      Vector[0, 0],
      Vector[6, 0],
      Vector[3, 1],
      Vector[0, 2],
      Vector[6, 2]
    ]
    grid = Grid.new(*vectors)

    assert_equal 5, solve(vectors)
  end

  def test_solve_input
    input = File.read('input.txt').split("\n").map { |row| Vector.from_string(row) }

    assert_equal 5358, solve(input)
  end

  def solve(input)
    Grid.new(*input).biggest_finite_area
  end
end
