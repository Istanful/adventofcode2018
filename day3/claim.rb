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

  def include?(other_claim)
    other_claim.x <= x + width && (other_claim.y + other_claim.height ) >= y ||
      other_claim.x + other_claim.width >= x && other_claim.y <= (y + height)
  end

  private

  def analayze_input
    input.match(/#(\d*) @ (\d*),(\d*): (\d*)x(\d*)/).to_a.map(&:to_i)
  end
end
