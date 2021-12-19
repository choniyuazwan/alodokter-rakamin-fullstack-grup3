class DocSpe < ApplicationRecord
  belongs_to :doctor
  belongs_to :specialization
  validates :doctor_id, :specialization_id, presence: true, length: { minimum: 1 }
end
