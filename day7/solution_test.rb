require 'minitest/autorun'
require_relative 'instruction'
require_relative 'dependency_tree'

class SolutionTest < MiniTest::Test
  def test_basic
    instructions = [
      Instruction['B', 'A'],
      Instruction['C', 'B']
    ]

    assert_equal 'CBA', solve(instructions)
  end

  def test_input
    input = File.read('input.txt').split("\n").map do |row|
      Instruction.from_string(row)
    end

    pp solve(input)

    assert false
  end

  def test_solve_example
    instructions = [
      Instruction['C', 'A'],
      Instruction['C', 'F'],
      Instruction['A', 'B'],
      Instruction['A', 'D'],
      Instruction['B', 'E'],
      Instruction['D', 'E'],
      Instruction['F', 'E']
    ]

    assert_equal 'CABDFE', solve(instructions)
  end

  private

  def solve(instructions)
    completed_steps = []

    grouped_steps = instructions.group_by(&:step).transform_values do |instructions|
      instructions.map(&:dependent_step)
    end.to_a

    free_steps = grouped_steps.select do |(step, dependent_steps)|
      dependent_steps.length == 1
    end
    completed_steps += free_steps.map { |(step, dependent_steps)| dependent_steps.first }.uniq

    instruction_count = grouped_steps.length

    pp grouped_steps

    loop do
      next_step = grouped_steps.select do |(step, dependent_steps)|
        dependent_steps.all? { |s| completed_steps.include?(s) }
      end.sort_by(&:first).first

      puts "Given completion of steps #{completed_steps}, #{next_step} is next since it is dependent on #{next_step&.[](1)}"

      grouped_steps.delete_if do |(step, dependent_steps)|
        step == next_step.first
      end


      completed_steps << next_step.first

      break completed_steps.join('') + grouped_steps.first.first if completed_steps.length == instruction_count
    end
  rescue => e
    puts "Uh oh #{e}"
    pp grouped_steps
    pp completed_steps
  end
end
