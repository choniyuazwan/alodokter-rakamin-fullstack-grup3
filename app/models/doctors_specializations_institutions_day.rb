class DoctorsSpecializationsInstitutionsDay < ApplicationRecord
  belongs_to :doctors_specializations_institution
  belongs_to :day
end
