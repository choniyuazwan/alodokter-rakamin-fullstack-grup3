class User < ApplicationRecord
  has_secure_password
  has_many :bookings
  validates :email, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end