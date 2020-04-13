class Movie < ApplicationRecord
  belongs_to :user

  delegate :email, to: :user, allow_nil: true, prefix: true

  validates :youtube_url, presence: true
end
