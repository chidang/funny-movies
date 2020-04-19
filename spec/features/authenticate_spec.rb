require 'rails_helper'

RSpec.describe 'Login / Register AND Logout', type: :feature do
  scenario 'Allow logged in user share Youtube video' do
    create(:user, email: 'chid@example.com', password: '12345678')
    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Login / Register'
    expect(page).to have_content('Welcome chid@example.com')
    expect(page).to_not have_content('Login / Register')
    visit new_movie_path
    expect(page).to have_content('Share a Youtube movie')
  end

  scenario 'Limiting access' do
    visit new_movie_path
    expect(page).to_not have_content('Share a Youtube movie')
    expect(page).to have_content('Currently, don\'t have any movies available.')
  end
end
