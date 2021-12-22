class DocSpeInsDay < ApplicationRecord
  belongs_to :doc_spe_in
  belongs_to :day
  has_many :doc_spe_ins_day_hous
  validates :doc_spe_in_id, :day_id, presence: true, length: { minimum: 1 }
end
