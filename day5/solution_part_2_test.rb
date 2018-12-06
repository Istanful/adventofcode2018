require 'minitest/autorun'
require_relative 'reaction'

class SolutionPart2Test < MiniTest::Test
  def test_solution
    input = File.read('input.txt').chomp

    assert_equal 4624 , solve(input)
  end

  def solve(input)
    alphabet = 'a'..'z'

    alphabet.map do |letter|
      sanitized_input = input.gsub(letter, '').gsub(letter.upcase, '')
      Reaction.new(sanitized_input).apply.length
    end.min
  end
end
