require 'minitest/autorun'
require_relative 'vector'

class VectorTest < MiniTest::Test
  def test_from_string
    vector = Vector.from_string('61, 90')

    assert_equal 61, vector.x
    assert_equal 90, vector.y
  end

  def test_manhattan_distance
    one = Vector[0, 0]
    two = Vector[2, 2]

    assert_equal 4, one.manhattan_distance(two)
  end
end
