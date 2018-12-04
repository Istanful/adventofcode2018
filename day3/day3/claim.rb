class Claim
  attr_reader :input, :id, :x, :y, :width, :height

  def initialize(input)
    @input = input
    _, @id, @x, @y, @width, @height = analayze_input
  end

  def claimed_inches
    memo = []
    height.times do |y_index|
      width.times do |x_index|
        memo << { x: x + x_index, y: y + y_index }
      end
    end
    memo
  end

  private

  def analayze_input
    input.match(/#(\d*) @ (\d*),(\d*): (\d*)x(\d*)/).to_a.map(&:to_i)
  end
end
