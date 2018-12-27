require 'minitest/autorun'
require_relative 'dependency_tree'
require_relative 'instruction'

class DependencyTreeTest < MiniTest::Test
  def test_basic
    instructions = [
      Instruction['B', 'A'],
      Instruction['C', 'B']
    ]

    assert_equal({ 'C' => { 'B' => 'A' } }, DependencyTree.new(instructions).to_h)
  end

  def test_example
    instructions = [
      Instruction['C', 'A'],
      Instruction['C', 'F'],
      Instruction['A', 'B'],
      Instruction['A', 'D'],
      Instruction['B', 'E'],
      Instruction['D', 'E'],
      Instruction['F', 'E']
    ]

    assert_equal({
      'C' => {
        'A' => {
          'B' => 'E',
          'D' => 'E'
        },
        'F' => 'E'
      }
    }, DependencyTree.new(instructions).to_h)
  end
end
