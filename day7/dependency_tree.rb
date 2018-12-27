class DependencyTree
  attr_reader :instructions

  def initialize(instructions)
    @instructions = instructions
  end

  def to_h
    solve(instructions)
  end

  private

  def solve(instructions, memo = {}, last = nil)
    if instructions.empty?
      return last.step
    end

    roots = instructions.select do |instruction|
      instructions.none? { |i| instruction.depend_on?(i)}
    end

    new_tree = {}
    roots.each do |root|
      if last.nil?
        next_instructions = instructions - roots
      else
        next_instructions = instructions.select do |instruction|
          instruction.depend_on?(root)
        end
      end

      memo[root.dependent_step] = solve(next_instructions, new_tree, root)
    end

    memo
  end
end
