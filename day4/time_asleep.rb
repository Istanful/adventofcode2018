class TimeAsleep
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def to_i
    sum = 0
    minute = 0

    entries.each do |entry|
      if entry.include?('falls')
        minute = entry[/:(\d*)/, 1].to_i
      elsif entry.include?('wakes')
        sum += (entry[/:(\d*)/, 1].to_i - minute) - 1
      end
    end

    sum
  end
end
