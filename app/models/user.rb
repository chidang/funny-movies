class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, presence: true, length: { minimum: 8 }, confirmation: false, on: :create
  validates :password, presence: true, length: { minimum: 8 }, on: :update

  has_secure_password

  has_many :movies
end
