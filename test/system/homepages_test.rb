require "application_system_test_case"

class HomepagesTest < ApplicationSystemTestCase

  test 'show next planned batches' do

    round = Round.new day: 'Dimanche'
    batch_yesterday = Batch.new round: round,
                                date: Date.today - 1.day,
                                bread: 'Epeautre'
    batch_yesterday.save!
    batch_today = Batch.new round: round,
                            date: Date.today,
                            bread: 'Kamut'
    batch_today.save!
    batch_tomorrow = Batch.new round: round,
                               date: Date.today + 1.day,
                               bread: 'Blé ancien'
    batch_tomorrow.save!
    batch_after_tomorrow = Batch.new round: round,
                                     date: Date.today + 2.days,
                                     bread: 'Engrain'
    batch_after_tomorrow.save!
    batch_in_3_days = Batch.new round: round,
                                date: Date.today + 3.days,
                                bread: 'Multi-céréales'
    batch_in_3_days.save!


    visit root_path
    refute page.has_content?('Epeautre')
    assert page.has_content?('Kamut')
    assert page.has_content?('Blé ancien')
    assert page.has_content?('Engrain')
    refute page.has_content?('Multi-céréales')

    refute page.has_content?(batch_yesterday.date.strftime("%e %B %Y"))
    assert page.has_content?(batch_today.date.strftime("%e %B %Y"))
    assert page.has_content?(batch_tomorrow.date.strftime("%e %B %Y"))
    refute page.has_content?(batch_in_3_days.date.strftime("%e %B %Y"))

  end


end
