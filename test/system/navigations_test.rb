require "application_system_test_case"

class NavigationsTest < ApplicationSystemTestCase
  test 'anonymous navigation' do
    visit root_path
    refute page.has_content?("Mon compte")
    refute page.has_content?("Admin")
    click_on 'Abonnements', match: :first
    assert_equal current_path, rounds_path
    assert page.has_content?("points de distribution")
    click_on 'Créer un compte', match: :first
    assert_equal current_path, new_user_path
    assert page.has_content?("J'ai déjà un compte.")
    fill_in 'Email', with: 'randomuser@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Créer un compte'
    assert_equal current_path, account_path
    assert page.has_content?("Mon compte")
    refute page.has_content?("Admin")
    assert page.has_content?(User.first.email)
    click_on 'Se déconnecter'
    assert_equal current_path, root_path
    refute page.has_content?("Mon compte")
    visit account_path
    assert_equal current_path, login_path
  end

  test 'registered navigation' do
    user = User.new email: 'new_user@gmail.com', password: 'password'
    user.save!
    visit root_path
    refute page.has_content?("Mon compte")
    refute page.has_content?("Admin")
    click_on 'Abonnements', match: :first
    assert_equal current_path, rounds_path
    assert page.has_content?("points de distribution")
    click_on 'Se connecter', match: :first
    assert_equal current_path, new_session_path
    assert page.has_content?("Je n'ai pas encore de compte.")
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Se connecter'
    assert_equal current_path, account_path
    assert page.has_content?("Mon compte")
    refute page.has_content?("Admin")
    assert page.has_content?(user.email)
    click_on 'Se déconnecter'
    assert_equal current_path, root_path
    refute page.has_content?("Mon compte")
    visit account_path
    assert_equal current_path, login_path
  end

  test 'admin navigation' do
    user = User.new email: 'new_user@gmail.com', password: 'password', role: 'admin'
    user.save!
    visit root_path
    refute page.has_content?("Mon compte")
    refute page.has_content?("Admin")
    click_on 'Abonnements', match: :first
    assert_equal current_path, rounds_path
    assert page.has_content?("points de distribution")
    click_on 'Se connecter', match: :first
    assert_equal current_path, new_session_path
    assert page.has_content?("Je n'ai pas encore de compte.")
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Se connecter'
    assert_equal current_path, account_path
    assert page.has_content?("Mon compte")
    assert page.has_content?("Admin")
    assert page.has_content?(user.email)
    click_on 'Admin', match: :first
    assert_equal current_path, admin_root_path
    assert page.has_content?("New location")
    click_on 'Back to app'
    assert_equal current_path, root_path
    assert page.has_content?("Mon compte")
    assert page.has_content?("Admin")
    click_on 'Se déconnecter'
    assert_equal current_path, root_path
    refute page.has_content?("Mon compte")
    visit account_path
    assert_equal current_path, login_path
  end

end
