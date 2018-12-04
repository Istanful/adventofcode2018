require 'minitest/autorun'

# --- Part Two ---
# Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.
#
# The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:
#
# abcde
# fghij
# klmno
# pqrst
# fguij
# axcye
# wvxyz
# The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.
#
# What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)
class SolutionTest < MiniTest::Test
  def test_basic
    input = %w[
      aaaa
      abcd
      aaab
    ]

    assert_equal 'aaa', solve(input)
  end

  def test_input
    input = File.read('input.txt').split("\n")

    pp solve(input)

    assert_equal true, false
  end

  def solve(input)
    input.map do |code|
      other_code = input.find do |comparing_code|
        next false if comparing_code == code
        comparing_code.chars.zip(code.chars).count do |arr|
          arr.uniq.length == 1
        end == code.length - 1
      end

      next if other_code.nil?
      break code.chars.zip(other_code.chars).map {|a| a.uniq.count == 1 ? a[0] : nil }.compact.join
    end
  end
end
