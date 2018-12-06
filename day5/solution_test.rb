require 'minitest/autorun'
require_relative 'reaction'

class SolutionTest < Minitest::Test
  def test_no_reaction
    input = 'abAB'

    assert_equal 'abAB', solve(input)
  end

  def test_one_reaction
    assert_equal 'b', solve('aAb')
    assert_equal 'b', solve('Aab')
  end

  def test_two_reactions
    assert_equal '', solve('baAB')
  end

  def test_input
    input = File.read('input.txt')

    assert 10450, solve(input).chomp.size
  end

  def solve(input)
    Reaction.new(input).apply
  end
end


