class Doctor < ApplicationRecord
  has_many :doc_spes
  validates :name, presence: true, length: { minimum: 3 }
end
