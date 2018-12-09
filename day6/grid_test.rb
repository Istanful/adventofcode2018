require 'minitest/autorun'
require_relative 'grid'

class GridTest < MiniTest::Test
  def test_points_with_finite_distances
    corners = [
      Vector[0, 0],
      Vector[2, 0],
      Vector[0, 2],
      Vector[2, 2]
    ]

    finite_vectors = [
      Vector[1, 1]
    ]

    # X X
    #  X
    # X X
    grid = Grid.new(*(corners + finite_vectors))

    assert_equal finite_vectors, grid.finite_vectors
  end

  def test_occupied_areas
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

    assert_equal [5], grid.occupied_areas
  end
end
