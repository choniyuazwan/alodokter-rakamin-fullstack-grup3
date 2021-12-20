class Day < ApplicationRecord
  has_many :doc_spe_ins_days
  validates :name, presence: true, length: { minimum: 3 }
end
