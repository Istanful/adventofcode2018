require 'minitest/autorun'

class SolutionTest < MiniTest::Test
  def test_basic
    input = "+1, +1"

    assert_equal solve(input), 2
  end

  def test_with_minus
    input = "+1, -3"

    assert_equal solve(input), -2
  end

  def test_advanced
    input = "+1, -3"

    assert_equal solve(input), -2
  end

  def test_actual
    input = File.read('input.txt').split("\n").join(', ')

    assert_equal solve(input), 402
  end

  def solve(input)
    input.split(',').sum(&:to_i)
  end
end
