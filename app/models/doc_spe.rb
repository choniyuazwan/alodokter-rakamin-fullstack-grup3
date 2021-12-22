class DocSpe < ApplicationRecord
  belongs_to :doctor
  belongs_to :specialization
  has_many :doc_spe_ins
  validates :doctor_id, :specialization_id, presence: true, length: { minimum: 1 }
end
