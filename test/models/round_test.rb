require 'test_helper'

class RoundTest < ActiveSupport::TestCase

  test 'the first Round created is first in the list' do
     first_round = Round.new day: 'Lundi'
     first_round.save!
     second_round = Round.new day: 'Mardi'
     second_round.save!
     assert_equal(first_round, Round.all.first)
  end

  test 'updated_at is changed after updating day' do
    round = Round.new day: 'Mercredi'
    round.save!
    first_updated_at = round.updated_at
    round.day = 'Jeudi'
    round.save!
    refute_equal(round.updated_at, first_updated_at)
  end

  test 'the first Location added to a Round is first in the list' do
    location_1 = Location.new name: 'New York',
                              address: 'Bleeker Street, New York'
    location_1.save!
    location_2 = Location.new name: 'Paris',
                              address: 'Av. des Champs-Elysées, Paris'
    location_2.save!
    location_3 = Location.new name: 'Madrid',
                              address: 'Plaza Mayor, Madrid'
    location_3.save!
    round = Round.new day: 'Lundi'
    round.locations << location_1
    round.locations << location_2
    round.save!
    assert_equal(round.locations.first.name, "New York")
    round.locations.destroy(location_1)
    round.save!
    refute_equal(round.locations.first.name, "New York")
    assert_equal(round.locations.first.name, "Paris")
    round.locations << location_3
    round.save!
    assert_equal(round.locations.first.name, "Paris")
  end

  test 'round has no day' do
    round = Round.new
    refute round.valid?
  end

  test 'round has wrong day' do
    round = Round.new day: 'Jeudredi'
    refute round.valid?
  end

end
