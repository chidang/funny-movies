require 'rails_helper'

RSpec.describe 'Login / Register AND Logout', type: :feature do
  scenario 'Login: valid inputs' do
    create(:user, email: 'chid@example.com', password: '12345678')

    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Login / Register'
    expect(page).to have_content('Welcome chid@example.com')
    expect(page).to_not have_content('Login / Register')
  end

  scenario 'Login: password is not correct' do
    create(:user, email: 'chid@example.com', password: '12345678')

    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '123456789'
    click_on 'Login / Register'
    expect(page).to have_content('Wrong password. Please try again.')
    expect(page).to_not have_content('Welcome chid@example.com')
  end

  scenario 'Register: valid inputs' do
    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '123456789'
    click_on 'Login / Register'
    expect(page).to have_content('chid@example.com')
    expect(page).to_not have_content('Login / Register')
  end

  scenario 'Invalid inputs' do
    visit root_path
    click_on 'Login / Register'
    expect(page).to have_content("Email can't be blank, Email is invalid")
    expect(page).to have_content("Password can't be blank, Password is too short (minimum is 8 characters)")
  end

  scenario "Login and Logout" do
    create(:user, email: 'chid@example.com', password: '12345678')

    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Login / Register'
    expect(page).to have_content('Welcome chid@example.com')
    expect(page).to_not have_content('Login / Register')
    click_on 'Logout'
    expect(page).to_not have_content('Welcome chid@example.com')
    expect(page).to_not have_content('Logout')
    expect(page).to have_content('Currently, don\'t have any movies available.')
  end
end
