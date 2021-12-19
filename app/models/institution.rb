class Institution < ApplicationRecord
  has_many :doc_spe_ins
  validates :name, presence: true, length: { minimum: 3 }
end
