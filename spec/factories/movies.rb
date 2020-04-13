FactoryGirl.define do
  factory :movie do
    title Faker::Movies::StarWars.character
    description Faker::Movies::StarWars.quote
    youtube_url 'https://www.youtube.com/watch?v=x3T-1wJCtFI'
    youtube_id  'x3T-1wJCtFI'
    user
  end
end
