class TimeAsleep
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def to_i
    sum = 0
    minute = 0

    entries.each do |entry|
      if entry.falling_asleep?
        minute = entry.minute
      elsif entry.waking_up?
        sum += (entry.minute - minute) - 1
      end
    end

    sum
  end
end
