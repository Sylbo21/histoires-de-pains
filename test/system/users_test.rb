require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  test 'sign up (creates a new user)' do
    visit root_path
    click_on 'Créer un compte', match: :first
    assert_equal current_path, new_user_path
    assert page.has_content?("J'ai déjà un compte.")
    fill_in 'Email', with: 'randomuser@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Créer un compte'
    assert_equal(1, User.all.count)
    assert_equal('randomuser@gmail.com', User.first.email)
    assert_equal current_path, account_path
    assert page.has_content?("Email: randomuser@gmail.com")
  end

  test 'sign up fails (wrong formatted email)' do
    visit new_user_path
    fill_in 'Email', with: 'randomuser.gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Créer un compte'
    assert_equal(0, User.all.count)
    assert_equal current_path, users_path
    assert page.has_content?("Email is invalid.")
  end

  test 'sign up fails (no email)' do
    visit new_user_path
    fill_in 'Password', with: 'password'
    click_button 'Créer un compte'
    assert_equal(0, User.all.count)
    assert_equal current_path, users_path
    assert page.has_content?("Email can't be blank.")
  end

  test 'sign up fails (no password)' do
    visit new_user_path
    fill_in 'Email', with: 'randomuser@gmail.com'
    click_button 'Créer un compte'
    assert_equal(0, User.all.count)
    assert_equal current_path, users_path
    assert page.has_content?("Password can't be blank.")
  end

  test 'log in (does not create a new user)' do
    user = User.new email: 'new_user@gmail.com', password: 'password'
    user.save!
    visit root_path
    click_on 'Se connecter', match: :first
    assert_equal current_path, new_session_path
    assert page.has_content?("Je n'ai pas encore de compte.")
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Se connecter'
    assert_equal(1, User.all.count)
    assert_equal('new_user@gmail.com', User.first.email)
    assert_equal('new_user@gmail.com', user.email)
    assert_equal current_path, account_path
    assert page.has_content?("Mon compte")
    assert page.has_content?("Email: new_user@gmail.com")
    assert page.has_content?("Email: #{user.email}")
  end

  test 'log in fails (wrong formatted email)' do
    user = User.new email: 'new_user@gmail.com', password: 'password'
    user.save!
    visit new_session_path
    fill_in 'Email', with: 'new_user.gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Se connecter'
    assert_equal current_path, sessions_path
    assert page.has_content?("L'email et/ou le mot de passe ne sont pas valides. Veuillez réessayer.")
  end

  test 'log in fails (no email)' do
    user = User.new email: 'new_user@gmail.com', password: 'password'
    user.save!
    visit new_session_path
    fill_in 'Password', with: 'password'
    click_button 'Se connecter'
    assert_equal current_path, sessions_path
    assert page.has_content?("L'email et/ou le mot de passe ne sont pas valides. Veuillez réessayer.")
  end

  test 'log in fails (no password)' do
    user = User.new email: 'new_user@gmail.com', password: 'password'
    user.save!
    visit new_session_path
    fill_in 'Email', with: 'randomuser@gmail.com'
    click_button 'Se connecter'
    assert_equal current_path, sessions_path
    assert page.has_content?("L'email et/ou le mot de passe ne sont pas valides. Veuillez réessayer.")
  end

  test 'log out' do
    user = User.new email: 'new_user@gmail.com', password: 'password'
    user.save!
    visit new_session_path
    fill_in 'Email', with: 'new_user@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Se connecter'
    assert_equal current_path, account_path
    click_on 'Se déconnecter'
    assert_equal current_path, root_path
    refute page.has_content?("Mon compte")
    visit account_path
    assert_equal current_path, login_path
  end

end
