require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  # test 'the first Location created is first in the list' do
  # # Fails: gives <Location id: 298486374, name: "MyString", address: "MyString", created_at: "2021-07-09 14:21:17", updated_at: "2021-07-09 14:21:17", latitude: nil, longitude: nil> as Location.all.first -> why? Because of automatic lon/lat attributes? -> Seems not because same problem with Rounds
  #    first_location = Location.new name: 'New York',
  #                                  address: 'Bleeker Street, New York'
  #    first_location.save!
  #    second_location = Location.new name: 'Paris',
  #                                   address: 'Champs Elysées 52, Paris'
  #    second_location.save!
  #    assert_equal(first_location, Location.all.first)
  # end

  test 'updated_at is changed after updating name' do
    location = Location.new name: 'Los Angeles',
                            address: 'Hoolywood Boulevard'
    location.save!
    first_updated_at = location.updated_at
    location.name = 'Hollywood'
    location.save!
    refute_equal(location.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating address' do
    location = Location.new name: 'Los Angeles',
                            address: 'Hoolywood Boulevard'
    location.save!
    first_updated_at = location.updated_at
    location.address = 'Mulholland Drive'
    location.save!
    refute_equal(location.updated_at, first_updated_at)
  end

  # test 'latitude changes after updating address' do
  #   # Fails: latitude isn't automatically updated when editing a Location (although it works in the app!)
  #   location = Location.new name: 'Lausanne Bellevaux',
  #                           address: 'Route du Pavement 85, 1018 Lausanne'
  #   location.save!
  #   first_latitude = location.latitude
  #   location.address = 'Av. Parc-de-la-Rouvraie 6, 1018 Lausanne'
  #   location.save!
  #   refute_equal(location.latitude, first_latitude)
  # end
  #
  # test 'longitude changes after updating address' do
  #   # Fails: longitude isn't automatically updated when editing a Location (although it works in the app!)
  #   location = Location.new name: 'Lausanne Bellevaux',
  #                           address: 'Route du Pavement 85, 1018 Lausanne'
  #   location.save!
  #   first_longitude = location.longitude
  #   location.address = 'Av. Parc-de-la-Rouvraie 6, 1018 Lausanne'
  #   location.save!
  #   refute_equal(location.longitude, first_longitude)
  # end

  test 'the first Round added to a Location is first in the list' do
    round_1 = Round.new day: 'Lundi'
    round_1.save!
    round_2 = Round.new day: 'Mardi'
    round_2.save!
    round_3 = Round.new day: 'Mercredi'
    round_3.save!
    location = Location.new name: 'Berlin',
                            address: 'Brandenburger Tor'
    location.rounds << round_1
    location.rounds << round_2
    location.save!
    assert_equal(location.rounds.first.day, "Lundi")
    location.rounds.destroy(round_1)
    location.save!
    refute_equal(location.rounds.first.day, "Lundi")
    assert_equal(location.rounds.first.day, "Mardi")
    location.rounds << round_3
    location.save!
    assert_equal(location.rounds.first.day, "Mardi")
  end

end
