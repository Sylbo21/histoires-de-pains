require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  test 'creating an account creates a new user' do
    visit root_path
    click_on 'Créer un compte', match: :first
    assert page.has_content?("J'ai déjà un compte.")
    fill_in 'Email', with: 'randomuser@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Créer un compte'
    assert_equal(1, User.all.count)
    assert_equal('randomuser@gmail.com', User.first.email)
    assert_equal current_path, root_path
  end

end
