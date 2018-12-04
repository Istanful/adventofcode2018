require 'minitest/autorun'
require 'set'

class SolutionPart2Test < MiniTest::Test
  def test_basic
    input = "+1, +2, -2"

    assert_equal solve(input), 1
  end

  def test_minus_case
    input = "+1, -2, +3, -3"

    assert_equal solve(input), -1
  end

  def test_input
    input = File.read('input.txt').split("\n").join(', ')

    assert_equal solve(input), 481
  end

  def solve(input)
    numbers = input.split(', ').map(&:to_i)
    i = 0
    sum = 0
    arr = [0].to_set

    loop do
      num = numbers[i%numbers.length]
      sum += num
      break sum if arr.include?(sum)
      arr << sum
      i += 1
    end
  end
end
