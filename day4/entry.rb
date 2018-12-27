class Entry
  attr_reader :string

  ID_REGEX = /Guard #(\d*)/
  TIMESTAMP_REGEX = /\[(.*)\]/
  MINUTE_REGEX = /:(\d*)/

  def initialize(string)
    @string = string
  end

  def guard_id
    string[ID_REGEX, 1]
  end

  def timestamp
    string[TIMESTAMP_REGEX, 1]
  end

  def falling_asleep?
    string.include?('falls')
  end

  def waking_up?
    string.include?('wakes')
  end

  def minute
    string[MINUTE_REGEX, 1].to_i
  end
end
