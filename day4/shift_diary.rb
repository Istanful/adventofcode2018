class ShiftDiary
  attr_reader :entries

  def initialize(entries)
    @entries = entries.map { |raw_entry| Entry.new(raw_entry) }
  end

  def sort
    entries.sort_by { |entry| entry.timestamp }
  end

  def guard_ids
    entries.map(&:guard_id).compact.uniq
  end

  def entries_for(guard_id)
    memo = []
    current_guard_id = guard_id
    sort.each_with_index do |entry, i|
      current_guard_id = entry.guard_id if entry.guard_id

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

    sort.each do |entry|
      if entry.falling_asleep?
        start_minute = entry.minute
      elsif entry.waking_up?
        end_minute = entry.minute
        periods << (start_minute...end_minute)
      end
    end

    periods
  end

  def minute_most_commonly_asleep
    asleep_minutes_map.max_by { |_key, value| value }&.first
  end
end
