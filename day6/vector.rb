class Vector
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.[](x, y)
    new(x, y)
  end

  def self.from_string(input)
    new(*input.split(',').map(&:to_i))
  end

  def -(other_vector)
    Vector.new(
      x - other_vector.x,
      y - other_vector.y
    )
  end

  def manhattan_distance(other_vector)
    vector = other_vector - self
    (vector.x.abs + vector.y.abs)
  end

  def abs
    Vector.new(
      x.abs,
      y.abs
    )
  end

  def inspect
    "Vector(#{x}, #{y})"
  end
end
