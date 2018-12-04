require "minitest/autorun"
require_relative "./claim"

class SolutionPart2Test < MiniTest::Test
  def test_input
    input = File.read('input.txt').split("\n").flat_map do |row|
      Claim.new(row)
    end

    assert_equal 506, solve_2(input)
  end

  def solve(claims)
    claims.find do |claim|
      claims.all? do |other_claim|
        next true if claim.id == other_claim.id
        (claim.claimed_inches - other_claim.claimed_inches) == claim.claimed_inches
      end
    end
  end
end
