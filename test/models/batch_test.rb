require 'test_helper'

class BatchTest < ActiveSupport::TestCase

  test 'the first Batch created is first in the list' do
     round = Round.new day: 'Lundi'
     first_batch = Batch.new round: round,
                             date: Date.parse('2021-09-13')
     first_batch.save!
     second_batch = Batch.new round: round,
                              date: Date.parse('2021-09-20')
     second_batch.save!
     assert_equal(first_batch, Batch.all.first)
  end

  test 'updated_at is changed after updating round' do
    round1 = Round.new day: 'Lundi'
    round2 = Round.new day: 'Mardi'
    batch = Batch.new round: round1,
                      date: Date.parse('2021-09-13')
    batch.save!
    first_updated_at = batch.updated_at
    batch.round = round2
    batch.save!
    refute_equal(batch.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating date' do
    round = Round.new day: 'Lundi'
    batch = Batch.new round: round,
                      date: Date.parse('2021-09-13')
    batch.save!
    first_updated_at = batch.updated_at
    batch.date = Date.parse('2021-09-20')
    batch.save!
    refute_equal(batch.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating bread' do
    round = Round.new day: 'Lundi'
    batch = Batch.new round: round,
                      date: Date.parse('2021-09-13'),
                      bread: 'Spelt'
    batch.save!
    first_updated_at = batch.updated_at
    batch.bread = 'Kamut'
    batch.save!
    refute_equal(batch.updated_at, first_updated_at)
  end

  test 'batch has all attributes' do
    round = Round.new day: 'Lundi'
    batch = Batch.new round: round,
                      date: Date.parse('2021-09-13'),
                      bread: 'Multigrain'
    assert batch.valid?
  end

  test 'batch has no bread' do
    round = Round.new day: 'Lundi'
    batch = Batch.new round: round,
                      date: Date.parse('2021-09-13')
    assert batch.valid?
  end

  test 'batch has no round' do
    batch = Batch.new date: Date.parse('2021-09-13'),
                      bread: 'Multigrain'
    refute batch.valid?
  end

  test 'batch has no date' do
    round = Round.new day: 'Lundi'
    batch = Batch.new round: round,
                      bread: 'Multigrain'
    refute batch.valid?
  end

  test 'batch has already taken date' do
    round = Round.new day: 'Lundi'
    batch1 = Batch.new round: round,
                       date: Date.parse('2021-09-13'),
                       bread: 'Multigrain'
    batch1.save!
    batch2 = Batch.new round: round,
                       date: Date.parse('2021-09-13'),
                       bread: 'Spelt'
    refute batch2.valid?
  end

  test 'future' do
    today = Date.today
    yesterday = today - 1.day
    tomorrow = today + 1.day
    after_tomorrow = today + 2.days
    round = Round.new day: 'Dimanche'
    batch_today = Batch.new round: round,
                            date: today
    batch_today.save!
    batch_yesterday = Batch.new round: round,
                                date: yesterday
    batch_yesterday.save!
    batch_tomorrow = Batch.new round: round,
                               date: tomorrow
    batch_tomorrow.save!
    batch_after_tomorrow = Batch.new round: round,
                                     date: after_tomorrow
    batch_after_tomorrow.save!
    assert_equal(Batch.future.length, 3)
    assert_includes(Batch.future, batch_today)
    assert_includes(Batch.future, batch_tomorrow)
    assert_includes(Batch.future, batch_after_tomorrow)
    refute_includes(Batch.future, batch_yesterday)
  end

  test 'chronological' do
    today = Date.today
    yesterday = today - 1.day
    tomorrow = today + 1.day
    after_tomorrow = today + 2.days
    round = Round.new day: 'Dimanche'
    batch_today = Batch.new round: round,
                            date: today
    batch_today.save!
    batch_yesterday = Batch.new round: round,
                                date: yesterday
    batch_yesterday.save!
    batch_after_tomorrow = Batch.new round: round,
                                     date: after_tomorrow
    batch_after_tomorrow.save!
    batch_tomorrow = Batch.new round: round,
                               date: tomorrow
    batch_tomorrow.save!
    assert_equal(Batch.chronological.length, 4)
    assert_equal(Batch.chronological.first.date, yesterday)
    assert_equal(Batch.chronological.last.date, after_tomorrow)
  end

  test 'next ones' do
    today = Date.today
    yesterday = today - 1.day
    tomorrow = today + 1.day
    after_tomorrow = today + 2.days
    round = Round.new day: 'Dimanche'
    batch_today = Batch.new round: round,
                            date: today
    batch_today.save!
    batch_yesterday = Batch.new round: round,
                                date: yesterday
    batch_yesterday.save!
    batch_after_tomorrow = Batch.new round: round,
                                     date: after_tomorrow
    batch_after_tomorrow.save!
    batch_tomorrow = Batch.new round: round,
                               date: tomorrow
    batch_tomorrow.save!
    assert_equal(Batch.next_ones.length, 3)
    assert_equal(Batch.next_ones.first.date, today)
    assert_equal(Batch.next_ones.last.date, after_tomorrow)
    refute_includes(Batch.future, batch_yesterday)
  end

  test 'very next ones' do
    today = Date.today
    yesterday = today - 1.day
    round = Round.new day: 'Dimanche'
    batch_today = Batch.new round: round,
                            date: today
    batch_today.save!
    batch_yesterday = Batch.new round: round,
                                date: yesterday
    batch_yesterday.save!
    6.times do |i|
      batch_future = Batch.new round: round,
                               date: today + i+1.days
      batch_future.save!
    end
    assert_equal(Batch.very_next_ones.length, 3)
    assert_equal(Batch.very_next_ones.first.date, today)
    refute_includes(Batch.future, batch_yesterday)
    refute_includes(Batch.very_next_ones, Batch.where(date: today + 5.days))
  end

end
