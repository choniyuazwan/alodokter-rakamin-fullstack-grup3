class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :doctors_specializations_institutions_days_hour
end
