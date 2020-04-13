require 'rails_helper'

RSpec.describe 'Share a Youtube Movie', type: :feature do
  scenario 'Valid Youtube movie' do
    create(:user, email: 'chid@example.com', password: '12345678')

    allow_any_instance_of(VideoInfo).to receive(:available?).and_return(true)
    allow_any_instance_of(VideoInfo).to receive(:title).and_return('Star wars')
    allow_any_instance_of(VideoInfo).to receive(:description).and_return('Star wars description')
    allow_any_instance_of(VideoInfo).to receive(:video_id).and_return('123')

    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Login / Register'
    visit new_movie_path
    expect(page).to have_content('Share a Youtube movie')
    fill_in 'Youtube URL', with: 'https://www.youtube.com/watch?v=x3T-1wJCtFI'
    click_on 'Share'
    expect(page).to have_content('Star wars')
    expect(page).to have_content('Shared by: chid@example.com')
    expect(page).to have_content('Description')
    expect(page).to have_content('Star wars description')
    expect(page).to_not have_content('Share a Youtube movie')
  end

  scenario 'Unavailable Youtube movie' do
    create(:user, email: 'chid@example.com', password: '12345678')

    allow_any_instance_of(VideoInfo).to receive(:available?).and_return(false)

    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Login / Register'
    visit new_movie_path
    expect(page).to have_content('Share a Youtube movie')
    fill_in 'Youtube URL', with: 'https://www.youtube.com/watch?v=x3T-ABC123'
    click_on 'Share'
    expect(page).to have_content('Video is not available')
    expect(page).to have_content('Share a Youtube movie')
  end

  scenario 'Youtube URL is not filled' do
    create(:user, email: 'chid@example.com', password: '12345678')

    visit root_path
    fill_in 'Email', with: 'chid@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Login / Register'
    visit new_movie_path
    expect(page).to have_content('Share a Youtube movie')
    fill_in 'Youtube URL', with: nil
    click_on 'Share'
    expect(page).to have_content('Please enter Youtube Video URL')
    expect(page).to have_content('Share a Youtube movie')
  end
end
