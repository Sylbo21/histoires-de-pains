location1 = Location.create! name: 'Lausanne Rouvraie',
                             address: 'Parc-de-la-Rouvraie 6, 1018 Lausanne'

location2 = Location.create! name: 'Palézieux-Village',
                             address: 'Ch. des Charbonneyres 1, 1607 Palézieux-Village'

location3 = Location.create! name: 'Corcelles-sur-Chavornay',
                             address: 'Le Château 3, 1374 Corcelles-sur-Chavornay'

round1 = Round.create! day: 'Lundi'
round2 = Round.create! day: 'Mardi'
round3 = Round.create! day: 'Mercredi'

batch1 = Batch.create! round: round1,
                       date: Date.parse('2021-09-13'),
                       bread: 'Kamut'

batch2 = Batch.create! round: round1,
                       date: Date.parse('2022-09-20'),
                       bread: 'Spelt'

batch3 = Batch.create! round: round2,
                       date: Date.parse('2022-09-14'),
                       bread: 'Multigrain'

batch4 = Batch.create! round: round2,
                       date: Date.parse('2022-09-21')

batch5 = Batch.create! round: round3,
                       date: Date.parse('2021-09-15')

user1 = User.create! email: 'sylviane@mail.com',
                     password: 'password',
                     first_name: 'Sylviane',
                     last_name: 'Borel',
                     phone: '0788941171',
                     address: 'Parc-de-la-Rouvraie 6',
                     npa: '1018',
                     city: 'Lausanne'

user2 = User.create! email: 'salvo@mail.com',
                     password: 'password',
                     first_name: 'Salvatore',
                     last_name: 'Cartesio'

user3 = User.create! email: 'noemi@mail.com',
                     password: 'password'

admin = User.create! email: 'jd@mail.com',
                     password: 'password',
                     first_name: 'Jean-Denis',
                     last_name: 'Borel',
                     role: 'admin'

round1.locations << location1
round1.locations << location2
round2.locations << location3
round3.locations << location1
round3.locations << location3
