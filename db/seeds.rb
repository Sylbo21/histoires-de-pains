location1 = Location.create! name: 'Rouvraie',
                             address: 'Parc-de-la-Rouvraie 6, 1018 Lausanne'

location2 = Location.create! name: 'Palézieux-Village',
                             address: 'Ch. des Charbonneyres 1, 1607 Palézieux-Village'

location3 = Location.create! name: 'Corcelles-sur-Chavornay',
                             address: 'Le Château 3, 1374 Corcelles-sur-Chavornay'

round1 = Round.create! day: 'Lundi'
round2 = Round.create! day: 'Mardi'
round3 = Round.create! day: 'Mercredi'

round1.locations << location1
round1.locations << location2
round2.locations << location3
round3.locations << location1
round3.locations << location3
