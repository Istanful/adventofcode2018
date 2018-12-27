class Instruction
  attr_reader :dependent_step, :step

  def initialize(dependent_step, step)
    @dependent_step = dependent_step
    @step = step
  end

  def self.[](dependent_step, step)
    new(dependent_step, step)
  end

  def self.from_string(string)
    _, dependent_step, step = string.match(/Step (.+) must be finished before step (.+) can begin./).to_a
    new(dependent_step, step)
  end

  def depend_on?(instruction)
    instruction.step == dependent_step
  end

  def inspect
    to_s
  end

  def to_s
    "#{dependent_step} then #{step}"
  end
end
