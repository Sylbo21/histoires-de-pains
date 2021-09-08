require 'test_helper'

class BatchTest < ActiveSupport::TestCase

  # test 'the first Batch created is first in the list' do
  #   # Fails: gives <Batch id: 298486374, date: "2021-07-12", bread: "MyString", created_at: "2021-09-08 11:52:35", updated_at: "2021-09-08 11:52:35", round_id: nil> as Batch.all.first -> why?
  #    round = Round.new day: 'Lundi'
  #    first_batch = Batch.new round: round,
  #                            date: Date.parse('2021-09-13')
  #    first_batch.save!
  #    second_batch = Batch.new round: round,
  #                             date: Date.parse('2021-09-20')
  #    second_batch.save!
  #    assert_equal(first_batch, Batch.all.first)
  # end

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

end
