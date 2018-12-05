require "minitest/autorun"
require "time"
require_relative "./shift_diary"
require_relative "./time_asleep"

class SolutionTest < MiniTest::Test
  def test_sorts_entries
    input = [
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-05 00:55] wakes up',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-04 00:02] Guard #99 begins shift'
    ]

    expected = [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:02] Guard #99 begins shift',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-05 00:55] wakes up'
    ]

    assert_equal expected, ShiftDiary.new(input).sort
  end

  def test_entries_for_guard
    input = [
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-05 00:55] wakes up',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-04 00:02] Guard #99 begins shift'
    ]

    expected = [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-03 00:29] wakes up',
    ]

    assert_equal expected, ShiftDiary.new(input).entries_for(10)
  end

  def test_time_asleep
    input = [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-03 00:29] wakes up',
    ]

    assert_equal 47, TimeAsleep.new(input).to_i
  end

  def test_guard_ids
    input = [
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-05 00:55] wakes up',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-04 00:02] Guard #99 begins shift'
    ]

    assert_equal [99, 10], ShiftDiary.new(input).guard_ids
  end

  def test_most_common_minute_asleep
    input = [
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-01 00:07] wakes up',
      '[1518-11-01 00:6] falls asleep',
      '[1518-11-01 00:7] wakes up',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-03 00:4] falls asleep',
      '[1518-11-03 00:5] wakes up',
    ]

    assert_equal 6, ShiftDiary.new(input).minute_most_commonly_asleep
  end

  def test_simple_solution
    input = [
      '[1518-11-02 00:40] falls asleep',
      '[1518-11-01 00:05] falls asleep',
      '[1518-11-03 00:24] falls asleep',
      '[1518-11-01 00:55] wakes up',
      '[1518-11-05 00:03] Guard #99 begins shift',
      '[1518-11-01 00:25] wakes up',
      '[1518-11-01 00:30] falls asleep',
      '[1518-11-01 00:00] Guard #10 begins shift',
      '[1518-11-05 00:55] wakes up',
      '[1518-11-02 00:50] wakes up',
      '[1518-11-05 00:45] falls asleep',
      '[1518-11-03 00:29] wakes up',
      '[1518-11-04 00:36] falls asleep',
      '[1518-11-03 00:05] Guard #10 begins shift',
      '[1518-11-04 00:46] wakes up',
      '[1518-11-01 23:58] Guard #99 begins shift',
      '[1518-11-04 00:02] Guard #99 begins shift'
    ]

    assert_equal 240, solve(input)
  end

  def test_input
    input = File.read('input.txt').split("\n")

    assert_equal 76357, solve(input)
  end

  def solve(input)
    master_shift_diary = ShiftDiary.new(input)
    individual_shift_diaries = master_shift_diary.guard_ids.map do |guard_id|
      ShiftDiary.new(master_shift_diary.entries_for(guard_id))
    end
    slacker_diary = individual_shift_diaries.max_by { |diary| TimeAsleep.new(diary.entries).to_i }
    slacker_diary.minute_most_commonly_asleep *  slacker_diary.guard_ids.first
  end
end
