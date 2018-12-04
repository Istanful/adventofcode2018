require 'minitest/autorun'

class SolutionTest < MiniTest::Test
  def test_basic
    input = %w[
     abcdef
     abadef
     aaabcd
    ]

    assert_equal solve(input), 1
  end

  def test_input
    input = File.read('input.txt').split("\n")

    assert_equal solve(input), 5000
  end

  def solve(input)
    twice_count, thrice_count = input.inject([0, 0]) do |memo, code|
      counts = code.chars.group_by(&:itself).values.map(&:length).uniq

      memo[0] += 1 if counts.include?(2)
      memo[1] += 1 if counts.include?(3)
      memo
    end

    twice_count * thrice_count
  end
end
