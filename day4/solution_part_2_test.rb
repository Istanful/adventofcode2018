require "minitest/autorun"
require "time"
require_relative "./shift_diary"
require_relative "./time_asleep"

class SolutionTest < MiniTest::Test
  def test_input
    input = File.read('input.txt').split("\n")

    assert 41668, solve(input)
  end

  def solve(input)
    master_shift_diary = ShiftDiary.new(input)
    individual_shift_diaries = master_shift_diary.guard_ids.map do |guard_id|
      ShiftDiary.new(master_shift_diary.entries_for(guard_id))
    end
    cool_diary = individual_shift_diaries.max_by do |diary|
      diary.asleep_minutes_map[diary.minute_most_commonly_asleep] || 0
    end
    cool_diary.minute_most_commonly_asleep * cool_diary.guard_ids.first
  end
end
