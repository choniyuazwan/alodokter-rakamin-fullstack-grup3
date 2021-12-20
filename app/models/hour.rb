class Hour < ApplicationRecord
  has_many :doc_spe_ins_day_hous
  validates :name, presence: true, length: { minimum: 3 }
end
