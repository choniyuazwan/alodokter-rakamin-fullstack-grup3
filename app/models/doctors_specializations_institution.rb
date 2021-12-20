class DoctorsSpecializationsInstitution < ApplicationRecord
  belongs_to :doctors_specialization
  belongs_to :institution
end
