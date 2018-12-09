require 'set'

class Grid
  attr_reader :vectors

  def initialize(*vectors)
    @vectors = vectors
    $cool_vectors = vectors
  end

  def finite_vectors
    @finite_vectors ||= vectors.select do |vector|
      other_vectors = (vectors - [vector])
      other_vectors.any? { |other_vector| other_vector.x > vector.x && other_vector.y > vector.y } &&
        other_vectors.any? { |other_vector| other_vector.x > vector.x && other_vector.y < vector.y } &&
        other_vectors.any? { |other_vector| other_vector.x < vector.x && other_vector.y < vector.y } &&
        other_vectors.any? { |other_vector| other_vector.x < vector.x && other_vector.y > vector.y }
    end
  end

  def each_position
    min_x = vectors.map(&:x).min
    max_x = vectors.map(&:x).max
    min_y = vectors.map(&:y).min
    max_y = vectors.map(&:y).max

    (min_x..max_x).to_a.each do |x|
      (min_y..max_y).to_a.each do |y|
        yield(Vector.new(x, y))
      end
    end
  end

  def solve_part_2
    safe_vectors = []

    each_position do |vector|
      distances = vectors.map do |other_vector|
        vector.manhattan_distance(other_vector)
      end
      is_safe = distances.sum < 10000

      if is_safe
        safe_vectors << vector
      end
    end

    safe_vectors.length
  end

  def biggest_finite_area
    new_vectors = []
    map = {}

    won_points = []

    each_position do |challenging_point|
      sorted_vectors = vectors.group_by do |v|
        v.manhattan_distance(challenging_point)
      end.to_a.sort_by { |v| v[0] }

      is_won = sorted_vectors[0][1].length == 1 && finite_vectors.include?(sorted_vectors[0][1].first)

      if is_won
        map[sorted_vectors[0][1].first] ||= 0
        map[sorted_vectors[0][1].first] += 1
      end
    end

    map.values.max
  end

  def display(highlight_vectors = [])
    max_x = vectors.map(&:x).max
    min_x = vectors.map(&:x).min
    min_y = vectors.map(&:y).min
    max_y = vectors.map(&:y).max
    scan_vectors = vectors.group_by(&:y)

    (min_y..max_y).each do |y|
      next puts() if scan_vectors[y].nil?
      row_vectors = scan_vectors[y].sort_by(&:x)

      (min_x..max_x).each do |x|
        if vector = row_vectors.find { |vector| vector.x == x && vector.y == y }
          if highlight_vectors.any? { |vector| vector.x == x && vector.y == y }
            print "\e[31mO\e[0m"
          else
            print "\e[34mX\e[0m"
          end
        else
          print ' '
        end
      end

     puts
    end
  end
end
