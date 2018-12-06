class Reaction
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def apply
    chars = []
    last_char = ''

    input.chars.each do |char|
      if char.downcase == last_char.downcase && char != last_char
        chars.pop
        last_char = chars.last || ''
      else
        chars << char
        last_char = char
      end
    end

    chars.join('')
  end
end
