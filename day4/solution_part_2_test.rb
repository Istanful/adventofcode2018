require "minitest/autorun"

class SolutionTest < MiniTest::Test
  def test_claim_parser
    input = '#1 @ 1,3: 4x5'

    claim = Claim.new(input)

    assert_equal 1, claim.id
    assert_equal 1, claim.x
    assert_equal 3, claim.y
    assert_equal 4, claim.width
    assert_equal 5, claim.height
  end

  def test_claimed_inches
    input = '#1 @ 1,3: 4x5'
    claim = Claim.new(input)

    claimed_inches = claim.claimed_inches

    assert_equal [
      { x: 1, y: 3 },
      { x: 2, y: 3 },
      { x: 3, y: 3 },
      { x: 4, y: 3 },
      { x: 1, y: 4 },
      { x: 2, y: 4 },
      { x: 3, y: 4 },
      { x: 4, y: 4 },
      { x: 1, y: 5 },
      { x: 2, y: 5 },
      { x: 3, y: 5 },
      { x: 4, y: 5 },
      { x: 1, y: 6 },
      { x: 2, y: 6 },
      { x: 3, y: 6 },
      { x: 4, y: 6 },
      { x: 1, y: 7 },
      { x: 2, y: 7 },
      { x: 3, y: 7 },
      { x: 4, y: 7 },
    ], claimed_inches
  end

  def test_basic_solution
    coordinates = [
      { x: 1, y: 1 },
      { x: 1, y: 1 },
      { x: 1, y: 2 },
    ]

    assert_equal 1, solve(coordinates)
  end

  def test_input
    input = File.read('day3/input.txt').split("\n").flat_map do |row|
      Claim.new(row).claimed_inches
    end

    assert_equal 109143, solve(input)
  end

  def solve(coordinates)
    coordinates.group_by(&:itself)
               .values.map(&:count)
               .count {|value| value >= 2}
  end
end
