class ShiftDiary
  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def sort
    entries.sort_by { |entry| Time.parse(entry[/\[(.*)\]/, 1]) }
  end

  def guard_ids
    entries.map do |entry|
      entry[/Guard #(\d*)/, 1]
    end.compact.uniq.map(&:to_i)
  end

  def entries_for(guard_id)
    memo = []
    current_guard_id = guard_id
    sort.each_with_index do |entry, i|
      unless entry[/Guard #(\d*)/, 1].nil?
        current_guard_id = entry[/Guard #(\d*)/, 1]
      end

      if current_guard_id == guard_id.to_s
        memo << entry
      end
    end
    memo
  end

  def asleep_minutes_map
    asleep_periods.inject({}) do |memo, period|
      period.each do |minute|
        memo[minute] ||= 0
        memo[minute] += 1
      end
      memo
    end
  end

  def asleep_periods
    start_minute = 0
    end_minute = 0
    periods = []

    entries.sort.each do |entry|
      if entry.include?('falls')
        start_minute = entry[/:(\d*)/, 1].to_i
      elsif entry.include?('wakes')
        end_minute = entry[/:(\d*)/, 1].to_i
        periods << (start_minute...end_minute)
      end
    end

    periods
  end

  def minute_most_commonly_asleep
    asleep_minutes_map.max_by { |_key, value| value }&.first
  end
end
